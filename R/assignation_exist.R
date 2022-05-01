#' Function to assign population to centers of services
#' @description Function to assign population to centers of services, based in proximity, maximum radius and nominal capacity of the centers. The capacity and maximum radius are defined a priori based on policies' objectives
#' 
#' @param pop Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS
#' @param centers Centers of services (dataframe with four variables: x, y, id, and capacity) x and y are plain coordinates in the defined CRS
#' @param d Maximum distance at which the center may provide service in meters
#' @param crs Coordinates reference system of pop and centers
#' @param route logical if FALSE the distance is calculated by Pythagorean formula, if TRUE the distance is calculated by "osrmRoute" function of "osrm" Package. Default = FALSE
#'
#' @return Return a LIST with:
#'     \item{new_centers }{Centers to cover the population}
#'     \item{new_assign }{Population with the center assigned}
#' 
#' @export
#'
#' @examples
#' assignation_exist(pop_epp, centers_epp, d = 1000, crs = sp::CRS("+init=epsg:32721"), route = FALSE)

assignation_exist <- function(pop, centers, d, crs, route = FALSE) {
        pop <- assign_voro(pop, centers, crs)
        if (route == F) {
            pop$dist_exist <- sqrt(((pop$x_pop - pop$x_center)^2) + ((pop$y_pop - pop$y_center)^2))    
        } 
        if (route == T) {
                EPP::osrm_ok()
                src_dst <- pop[, c("x_pop", "y_pop", "x_center", "y_center")]
                src_dst <- byosrmRoute(src_dst, crs) 
                pop$dist_exist <- src_dst$dist
        }
        pop$en1000_exist <- ifelse(pop$dist_exist >= d, 0, 1)
        ninos_id <- list(tapply(X = pop$en1000_exist, INDEX = list(pop$id), FUN = sum))
        ninos_conteo <- as.data.frame(c(ninos_id))
        names(ninos_conteo) <- c("ninos_ex")
        ninos_conteo$id <- row.names(ninos_conteo)
        pop <- merge(pop, ninos_conteo, by = "id", all.x = TRUE, all.y = TRUE)
        pop <- pop[order(pop$id, pop$dist_exist), ]
        lista_id <- as.data.frame(sort(unique(pop$id)))
        names(lista_id) <- c("id")
        lista_id$nid <- row.names(lista_id)
        pop <- merge(pop, lista_id, by = "id")
        lista_1 <- vector("list", nrow(lista_id))
        for (i in 1:nrow(lista_id)) {
             lista_1[[i]] <- rank(subset(pop, pop$nid == i)[, "dist_exist"], ties.method = "random")
        }
        pop$orden_dist <- unlist(lista_1)
        pop$reasig <- ifelse(pop$en1000_exist == 1, ifelse(pop$orden_dist <= pop$capacity, 0, 1), 1)
        pop$x <- pop$x_pop
        pop$y <- pop$y_pop
        cov <- subset(pop, pop$reasig == 0, c(x, y, weight, id), drop = TRUE)
        cov <- droplevels(cov)
        pop <- subset(pop, pop$reasig == 1, select = c(x, y, weight), drop = TRUE)
        pop <- droplevels(pop)
        assignation_exist.output <- list(pop_uncov = pop, pop_cov = cov)
}
