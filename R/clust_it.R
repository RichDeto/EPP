#' Function for iterative clustering
#' @description The function clusters population to create service's centers. Iterates EPP::clust_pop for the remaining population in each step. It allows to define two distances of service and two group sizes for several rounds of iteration.
#'
#' @param pop Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS
#' @param m Number of iteration rounds. Default 5
#' @param l Number of iteration rounds with the first group size (g1). Default 4
#' @param g1 Size of the groups for the first l iterations. Default 50
#' @param g2 Size of the groups for the last m-l iterations. Default g1 * 0.5
#' @param d1 Distance range of service for the first iterations Default 1000
#' @param d2 Second distance range of service. Default double of d1
#'
#' @return Return a LIST with:
#' \item{Clustered}{Population assigned to created centers by clusterization}
#' \item{pop}{Remaining non-assigned population}
#' @export
#' @examples
#' clu <- clust_it(pop = pop_epp)

clust_it <- function(pop, m = 5, l = 4, g1 = 5, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2){
        clusterizados <- as.list(NA)
        j <- 1 #iteration index
        n <- nrow(pop) #pob remainder
        while (j <= m & n >=  1 & ceiling(nrow(pop) / (ifelse(j <= l, g1, g2) * 0.75)) >= 2) { 
                pop <- clust_pop(pop, ceiling(nrow(pop) / (ifelse(j <= l, g1, g2) * 0.75))) 
                list_1 <- vector("list")
                for (i in sort(unique(pop$cluster))) {
                        list_1[[i]] <- rank(subset(pop, pop$cluster == i)[ ,"dist"], ties.method = "random")
                } # provides a list of ranks for each cluster, based on distance to the median center
                orden_dist <- as.data.frame(NULL)
                for (i in 1:length(list_1)) {
                        orden_dist <- rbind(orden_dist,as.data.frame(list_1[[i]]))
                }
                colnames(orden_dist) <- "orden_dist"
                pop <- cbind(pop[order(pop$cluster, pop$dist), ], orden_dist) # assigns the rank to the population
                remove(i, list_1)
                max_n_cl <- as.data.frame(tapply(pop$orden_dist[pop$dist <= ifelse(j <= l, d1, d2)], 
                                                           pop$cluster[pop$dist <= ifelse(j <= l, d1, d2)], max))
                max_n_cl$cluster <- as.factor(row.names(max_n_cl))
                names(max_n_cl) <- c("max_n_cl","cluster")
                max_n_cl$max_n_cl <- ifelse(is.na(max_n_cl$max_n_cl), 1, max_n_cl$max_n_cl)
                pop <- merge(pop, max_n_cl, by = "cluster" )
                pop$a_reasig <- ifelse(pop$orden_dist <= pop$max_n_cl & 
                                               pop$orden_dist <= ifelse(j <= l, g1, g2) &
                                               pop$max_n_cl >= ifelse(j <= l, g1, g2), 0, 1)
                if (nrow(pop) == sum(pop$a_reasig) & j == 1) {
                        stop("Your g1 value is too high for your population dispersion")    
                }
                if (nrow(pop) == sum(pop$a_reasig) & j == m + 1) {
                        stop("Your g2 value is too high for your population dispersion")   
                }
                clusterizados[[j]] <- subset(pop, pop$a_reasig == 0)
                clusterizados[[j]]$round <- as.factor(j)
                pop <- subset(pop, pop$a_reasig == 1, select = c(x, y, weight))
                n <- nrow(pop)
                j <- j + 1
        }
        list(clustered = clusterizados, pop = pop)
}
