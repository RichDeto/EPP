#' Function to generate buffers intersected by Voronoi polygons.
#' @description Generate buffers from points coordinates, according to a distance/s of radium, but intersect by Voronoi Polygons. The output of the function is a SpatialPolygonDataFrame with the id of the initial DataFrame.
#' @param x DataFrame with unless three variables: x, y, and id
#' @param id Variable name (Character) to identify cases. Default = 'id'
#' @param w_buff Buffer distance of radium in meters. Default = 1000
#' @param crs Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721")
#' @return Return a SpatialPolygonDataFrame with the sames variables of the initial DataFrame#' 
#' @importFrom rgeos gBuffer gIntersection 
#' @importFrom maptools unionSpatialPolygons 
#' @import sp
#' @export
#' @examples
#' buf_centers <- buff_voronoi(centers_epp, id = 'id', w_buff = 1000, 
#'                            crs = sp::CRS("+init=epsg:32721")) 
#' @references Bivand, R., Keitt, T., Rowlingson, B., Pebesma, E., Sumner, M., Hijmans, R. y Rouault, E. (2015), Bindings for the Geospatial Data Abstraction Library. URL https://cran.r-project.org/web/packages/rgdal/rgdal.pdf
#' Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
#' Farmer, Carson (2009) "http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/"
#' Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Documento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
#' Leisch, F. y Dimitriadou, E. (2013), Flexible Cluster Algorithms. URL https://cran.r-project.org/web/packages/flexclust/flexclust.pdf
#' Pebesma, E., Bivand, R., Rowlingson, B., Gomez-Rubio, V., Hijmans, R., Sumner, M., MacQueen, D. et al. (2015), Classes and Methods for Spatial Data. URL https://cran.r-project.org/web/packages/sp/sp.pdf
#' R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
#' Turner, R. (2015), Delaunay Triangulation and Dirichlet (Voronoi) Tessellation. URL https://cran.r-project.org/web/packages/deldir/deldir.pdf
#' @keywords Buffers Voronoi-Polygons

buff_voronoi <- function(x, id = 'id', w_buff = 1000, crs = sp::CRS("+init=epsg:32721")) {
        SPP <- SpatialPoints(x[ ,1:2], crs)
        suppressWarnings(SP <- voro_polygon(SPP))#, crs)## generate voronoipoligons of centers
        
        # if (.hasSlot(SPP, 'coords')) {
        #         crds <- SPP@coords  
        # } else crds <- SPP
        # z <- deldir(crds[ ,1], crds[ ,2], rw = c(SPP@bbox[1,1] - (SPP@bbox[1,1] * 0.05),
        #                                          SPP@bbox[1,2] + (SPP@bbox[1,2] * 0.05),
        #                                          SPP@bbox[2,1] - (SPP@bbox[2,1] * 0.05),
        #                                          SPP@bbox[2,2] + (SPP@bbox[2,2] * 0.05)))
        # w <- tile.list(z)
        # polys <- vector(mode = 'list', length = length(w))
        # for (i in seq(along = polys)) {
        #         pcrds <- cbind(w[[i]]$x, w[[i]]$y)
        #         pcrds <- rbind(pcrds, pcrds[1,])
        #         polys[[i]] <- Polygons(list(Polygon(pcrds)), ID = as.character(i))
        # }
        # SP <- SpatialPolygons(polys, proj4string = crs)
        
        SPD <- SpatialPolygonsDataFrame(SP, x ,match.ID = FALSE)
        SPDT <- SpatialPointsDataFrame(SPP, x, match.ID = FALSE)
        # id = paste0("SPDT$", id) 
        B_SPP <- gBuffer(SPDT, byid = T, width = w_buff)
        suppressWarnings(a <- gIntersection(B_SPP, SPD, byid = T, drop_lower_td = T)) 
        a <- SpatialPolygonsDataFrame(a, as.vector(subset(over(a, SPDT, returnList = F))), match.ID = F) 
        y <- unionSpatialPolygons(a, a@data[ ,id]) 
        b <- as.data.frame(c(1:length(y)))
        for (i in 1:length(y)) {
                b[i,1] <- y@polygons[[i]]@ID
        }
        names(b) <- id
        buf_voro <- SpatialPolygonsDataFrame(y, b, match.ID = F)
}
