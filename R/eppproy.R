eppproy <- function(pob, m = 5, l = 4, o = 3, g1 = 50, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2, crs = CRS("+init=epsg:32721")) {
  assigned <- assing_clust(clust_it(pop)[[1]])
  eppproy.output <- list (centros_clusters_s <- SpatialPointsDataFrame(SpatialPoints(assigned[[1]][,2:3],crs), 
                                                                       assigned[[1]], match.ID = TRUE), 
                          asigned_clusters_s <- SpatialPointsDataFrame(SpatialPoints(assigned[[2]][,2:3],crs),
                                                                       assigned[[2]], match.ID = TRUE))
} 
