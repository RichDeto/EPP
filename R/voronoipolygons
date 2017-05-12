voronoipolygons <- function(x, crs) { 
  # Voronoi script modify of "http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/"
  require(sp)
  require(deldir)
  if (.hasSlot(x, 'coords')) {
    crds <- x@coords  
  } else crds <- x
  z <- deldir(crds[,1], crds[,2],rw = c(x@bbox[1,1] - (x@bbox[1,1] * 0.05),
                                        x@bbox[1,2] + (x@bbox[1,2] * 0.05),
                                        x@bbox[2,1] - (x@bbox[2,1] * 0.05),
                                        x@bbox[2,2] + (x@bbox[2,2] * 0.05)))
  w <- tile.list(z)
  polys <- vector(mode = 'list', length = length(w))
  for (i in seq(along = polys)) {
    pcrds <- cbind(w[[i]]$x, w[[i]]$y)
    pcrds <- rbind(pcrds, pcrds[1,])
    polys[[i]] <- Polygons(list(Polygon(pcrds)), ID = as.character(i))
  }
  SP <- SpatialPolygons(polys,proj4string = crs)
}
