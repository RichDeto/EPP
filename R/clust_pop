clust_pop <- function(pop, k){ 
  require(flexclust) 
  pop$cluster <- as.factor(cclust(pop[,1:2],k)@cluster)
  medianx <- data.frame(medianx=as.vector(tapply(pop$x,pop$cluster,FUN = median)))
  mediany <- data.frame(mediany=as.vector(tapply(pop$y,pop$cluster,FUN = median)))
  pop <- merge(pop,medianx,by.x = "cluster",by.y = "row.names") 
  pop <- merge(pop,mediany,by.x = "cluster",by.y = "row.names")
  # Euclidean distance from each observation to the median center of its group
  pop$dist <- sqrt((pop$x - pop$medianx) ^ 2 + (pop$y - pop$mediany) ^ 2) 
  #ordered by distance
  pop <- pop[order(pop$cluster,pop$dist),] 
}
