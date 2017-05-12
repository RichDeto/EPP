eppexist <- function(pop,centers, n = 3, m = 0, d1 = 1000, d2 = d1 * 2, crs) {
  assigned <- as.list(NA)
  used_capacity <- as.list(NA) 
  dist <- c(rep.int(d1,n), rep.int(d2,m)) ## compiles a vector of distances
  for(i in 1:length(dist)){
    if (nrow(pop) > 0 & nrow(centers) > 0)
    iteration <- assignation_exist(pop, centers, dist[i], crs) ## assigns the population to the centers
    pop <- iteration[[1]]
    cov <- iteration[[2]]
    if (nrow(cov) > 0){
      cov$it <- i 
      cov$dist <- dist[i]
      cov$one <- 1
      cent1 <- merge(centers,
                    data.frame(used_cap = tapply(X = cov$one,INDEX = list(cov$id), FUN = sum)),
                    by.x = "id", by.y = "row.names", all.x = TRUE)
      cent1$used_cap <- ifelse(is.na(cent1$used_cap), 0, cent1$used_cap)
      cent1$capacity <- cent1$capacity - cent1$used_cap
      centers <- subset(cent1, cent1$capacity > 0, select = c(x, y, id, capacity), drop = TRUE) 
      centers <- droplevels(centers)
      used_capacity[[i]] <- cent1
      assigned[[i]] <- cov
      remove(cent1)
    }
    remove(cov)
  }
  eppexist.output <<- list(pop, centers, used_capacity, assigned )
} 
