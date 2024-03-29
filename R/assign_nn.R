#' assign_nn
#' @description Add nearest neighbor information by osrm route service
#' @param x {sf} object of source distance criteria or data.frame with "x" and "y" coordinates
#' @param y {sf} object of destination distance criteria or data.frame with "x" and "y" coordinates
#' @param y.id name of {y} variable for identification. Default "id"
#' @param k numeric value for the near neighbor linear criteria, to reduce the computation 
#' for nearest neighbor by route
#' @param crs Coordinate Reference Systems (CRS), used only if x or y are not {sf} . Default = "32721").
#'
#' @return x object with three new variables
#' \item{nn_id}{y.id of nearest neighbor}
#' \item{time}{time by car to nearest neighbor in minutes}
#' \item{dist}{distance by route to nearest neighbor in kilometers}
#' @export
#' @import sf
#' @import osrm
#' @importFrom dplyr '%>%'
#' @importFrom nngeo st_nn
#' @importFrom curl has_internet
#' @importFrom assertthat assert_that
#' @importFrom methods is
#' @examples
#' \donttest{
#' pop_epp_nn <- assign_nn(x = pop_epp[1:20,], y = centers_epp)
#' }

assign_nn <- function(x, y, y.id = "id", k = 10, crs = 32721){
        assertthat::assert_that(.x = curl::has_internet() & getOption("osrm.server") == "https://routing.openstreetmap.de/", 
                                msg = "No internet access was detected. Please check your connection.")
        if(!is(x, "sf")){
                x <- sf::st_as_sf(x, coords = c("x", "y"), remove = FALSE) %>% st_set_crs(crs)
        }
        if(!is(y, "sf")){
                y <- sf::st_as_sf(y, coords = c("x", "y"), remove = FALSE) %>% st_set_crs(crs)
        }
        EPP::osrm_ok()
        if(!y.id %in% names(y)) stop(paste(y.id, "is not a variable name of second object"))
        nn <- nngeo::st_nn(x, y, k = k, progress = FALSE)
        for (i in 1:length(nn)){
                vec <- osrmTable(src = x[i, ], dst = y[nn[[i]], ])[["durations"]]
                y_nn <- as.numeric(colnames(vec)[which.min(vec)])
                x[i, "nn_id"] <- y[y_nn, y.id] %>% 
                        sf::st_drop_geometry()
                x[i, "time"] <- vec[, which.min(vec)] 
                ruta <- osrm::osrmRoute(src = x[i,] %>% st_transform(4326),
                                        dst = y[y_nn, ] %>% st_transform(4326),
                                        overview = FALSE)
                x[i, "dist"] <- ruta[[2]]
        }
        return(x)
}
