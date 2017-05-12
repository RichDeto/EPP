assignation_exist <- function(pop, centers, d, crs) {
  require(sp)
  pob_s <- SpatialPoints(pop[,1:2],proj4string = crs)## transform pop to spatial object
  centers_s <- SpatialPoints(centers[,1:2],crs)## transform centers to spatial object
  VP_centers1 <- voronoipolygons(centers_s, crs)## generate voronoipoligons of centers
  centers$poligono <- over(VP_centers1,centers_s,returnList = FALSE)## assign centers info to voronoipoligons
  ab <- as.data.frame(over(pob_s,VP_centers1))## intersects the population with the voronoi polygons of the centers
  names(ab) <- "poligono"
  pop <- cbind(pop,ab)
  pop <- merge(pop,centers,by = "poligono")
  remove(ab)
  pop$dist_exist <- sqrt(((pop$x.x - pop$x.y) ^ 2) + ((pop$y.x - pop$y.y) ^ 2))## distance calculation between population and centers
  pop$en1000_exist <- ifelse(pop$dist_exist >= d,0,1) ## selects population inside the distance range
  ninos_id <- list(tapply(X = pop$en1000_exist,INDEX = list(pop$id),FUN = sum))## population count by center
  ninos_conteo <- as.data.frame(c(ninos_id))
  names(ninos_conteo) <- c("ninos_ex")
  ninos_conteo$id <- row.names(ninos_conteo)
  pop <- merge(pop, ninos_conteo,by = "id", all.x = TRUE, all.y = TRUE)
  pop <- pop[order(pop$id, pop$dist_exist),]## order by center & distance
  remove(ninos_conteo)
  lista_id <- as.data.frame(sort(unique(pop$id))) # list centers with assigned population
  names(lista_id) <- c("id")
  lista_id$nid <- row.names(lista_id)
  pop <- merge(pop,lista_id,by = "id")
  lista_1 <- vector("list", nrow(lista_id))
  for (i in 1:nrow(lista_id)) {
    lista_1[[i]] <- rank(subset(pop,pop$nid == i)[,"dist_exist"],ties.method = "random")
  } ## rank pop by center and distance
  pop$orden_dist <- unlist(lista_1) ## assigns rank to pop
  remove(lista_1)
  pop$reasig <- ifelse(pop$en1000_exist == 1,ifelse(pop$orden_dist <= pop$capacity,0,1),1) # population still uncovered, to reassign
  pop$x <- pop$x.x
  pop$y <- pop$y.x
  cov <- subset(pop, pop$reasig == 0, c(x,y,weight,id),drop = TRUE) ## population covered by the services
  cov <- droplevels(cov)
  pop <- subset(pop,pop$reasig == 1,select = c(x,y,weight),drop = TRUE) ## population still uncovered
  pop <- droplevels(pop)
  assignation_exist.output <- list(pop, cov, centers)
}  
