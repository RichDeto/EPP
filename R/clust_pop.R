clust_pop <- function(pop, k){ 
  pop$cluster <- as.factor(cclust(pop[,1:2],k)@cluster)
  medianx <- data.frame(medianx=as.vector(tapply(pop$x,pop$cluster,FUN = median)))
  mediany <- data.frame(mediany=as.vector(tapply(pop$y,pop$cluster,FUN = median)))
  pop <- merge(pop,medianx,by.x = "cluster",by.y = "row.names") 
  pop <- merge(pop,mediany,by.x = "cluster",by.y = "row.names")
  pop$dist <- sqrt((pop$x - pop$medianx) ^ 2 + (pop$y - pop$mediany) ^ 2) # Euclidean distance to the median center of group 
  pop <- pop[order(pop$cluster,pop$dist),]  #ordered by distance
}
