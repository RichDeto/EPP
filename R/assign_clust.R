#' Function to assign population to centers of services
#' @description Function to process the results from EPP::clust_it
#'
#' @param clustered List of the population assigned to each center by EPP::clust_it
#'
#' @return list with Centers of the clusters with the number of individuals covered for each service distance 
#' and mean distances and Population with the center assigned to
#' @export
#' @examples 
#' a <- clust_it(pop_epp)
#' a <- assign_clust(clustered = a)

assign_clust <- function(clustered){
  asigned_clusters <- as.data.frame(NULL)
  for (i in 1:length(clustered[[1]])) {
    asigned_clusters <- rbind(asigned_clusters, as.data.frame(clustered[[1]][[i]]))
  }
  asigned_clusters$id <- paste(asigned_clusters$round, asigned_clusters$medianx, asigned_clusters$mediany, sep = "_")
  asigned_clusters$p_weight <- 0
  asigned_clusters$cubre <- 0
  asigned_clusters$p_dist <- 0
  for (i in unique(asigned_clusters$id)) {
    asigned_clusters[asigned_clusters$id == i, ]$cubre <- 
      nrow(asigned_clusters[asigned_clusters$id == i, ])
    asigned_clusters[asigned_clusters$id == i, ]$p_weight <- 
      round(sum(asigned_clusters[asigned_clusters$id == i, ]$weight) / 
              nrow(asigned_clusters[asigned_clusters$id == i, ]), 2)
    asigned_clusters[asigned_clusters$id == i, ]$p_dist <-
      round(mean(asigned_clusters[asigned_clusters$id == i, ]$dist), 2)
  }
  list(centers_clusters = subset(asigned_clusters, duplicated(asigned_clusters$id) == F,
                                 select = c(id, x, y, p_weight, medianx, mediany, p_dist, cubre, round)), 
       assigned_clusters = subset(asigned_clusters, select = c(id, x, y, weight, medianx, mediany, dist, round)))
}
