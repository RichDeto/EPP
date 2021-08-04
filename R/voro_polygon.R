#' @export voro_polygon
#' 
#' @title Calculate Voronoi polygons for a set of points
#'  
#' @description Calculate Voronoi polygons from a SpatialPoints object
#'  
#' @param x A SpatialPoints or SpatialPointsDataFrame object
#'  
#' @param bounding.polygon If present, this is a SpatialPolygons object specifying the 
#' bounding polygon(s) for the Voronoi polygons, and make the Voronoi polygons to be 
#' clipped to the outside bounding polygon. The outside bounding polygon
#' is the union of all polygons in bounding.polygon. If this is not present, the 
#' Voronoi polygons extend to a rectangle that is range.expand beyond the bounding box
#' of input points in all directions.
#' 
#' @param range.expand A length-one or length-two vector of expansion 
#' factors for the bounding box of points in x in the horizontal and vertical directions. 
#' If length = 1, it is replicated to length two. Element one is the fraction of the 
#' bounding box's horizontal width that is added and subtracted to the 
#' horizontal extent of the output polygons. Element two is the fraction of the 
#' bounding box's vertical height that is added and subtracted to the vertical extent 
#' of the output polygons.  Only this parameter's absolute value is used. If bounding.polygon
#' is present, this parameter is ignored. 
#'    
#' @return A SpatialPolygonsDataFrame containing the Voronoi polygons surrounding the points in x. Attributes of the output polygons are: 
#' \item{x}{The horizontal coordinate of the tessellation's defining point} 
#' \item{y}{The vertical coordinate of the tessellation's defining point}
#' \item{area}{Area of tessellation, in units of x's projection.}
#'  
#' @details This is a convenience routine for the deldir::deldir function. 
#' The hard work, computing the Voronoi polygons, is done by the deldir::deldir
#' and deldir::tile.list functions. See documentation for those functions for 
#' details of computations.
#' 
#' This function is convenient because it takes a SpatialPoints object and returns 
#' a SpatialPolygonsDataFrame object. 
#' 
#' @importFrom rgeos gUnion
#' @importFrom methods slot
#' @import sp
#' @examples 
#' x <- sp::SpatialPoints(centers_epp[ ,1:2])
#' centers_voro <- voro_polygon(x)

voro_polygon <- function(x, bounding.polygon = NULL, range.expand = 0.1) {
        if (!inherits(x, "SpatialPoints")) {
                stop("Must pass a SpatialPoints* object to voro_polygons.")
        }
        crds = coordinates(x)
        if ( is.null(bounding.polygon) ) {
                if ( length(range.expand) == 1) {
                        range.expand <- rep(range.expand,2)
                } else if (length(range.expand) > 2 ) {
                        warning("Only first two elements of range.expand used in voro_polygons")
                        range.expand <- range.expand[1:2]
                }
                dxy <- diff(c(t(sp::bbox(x))))[c(1,3)]
                bb <- sp::bbox(x) + (matrix(dxy, nrow = 2, ncol = 1) %*% 
                                             matrix(c(-1, 1), nrow = 1, ncol = 2)) * abs(range.expand)
                bb <- c(t(bb))
        } else {
                bb = c(t(sp::bbox(bounding.polygon)))
        }
        z = deldir::deldir(crds[,1], crds[,2], rw = bb)
        w = deldir::tile.list(z)
        polys = vector(mode = 'list', length = length(w))
        for (i in seq(along = polys)) {
                pcrds = cbind(w[[i]]$x, w[[i]]$y)
                pcrds = rbind(pcrds, pcrds[1,])
                polys[[i]] = Polygons(list(Polygon(pcrds)), ID = as.character(i))
        }
        SP = SpatialPolygons(polys, proj4string = CRS(proj4string(x)))
        voronoi = SpatialPolygonsDataFrame(SP, 
                                           data = data.frame(x = crds[,1], 
                                                             y = crds[,2], 
                                                             area = sapply(slot(SP, "polygons"), 
                                                                           slot, "area"),
                                                             row.names = sapply(slot(SP, 'polygons'),
                                                                                slot, "ID")))
        # Clip to some layer, if called for
        if (!is.null(bounding.polygon)) {
                # If multiple polygons in bound, get just the outside bounding polygon
                bounding.polygon <- gUnion( bounding.polygon, bounding.polygon )
                voronoi.clipped <- gIntersection( voronoi, bounding.polygon, byid = TRUE,
                                                  id = row.names(voronoi))
                df <- data.frame(voronoi)
                df$area <- sapply(slot(voronoi.clipped,"polygons"), slot, "area")  # new areas
                voronoi <- SpatialPolygonsDataFrame( voronoi.clipped, df)
        }
        voronoi
}