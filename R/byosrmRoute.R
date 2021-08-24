#' Add the Shortest Path Between Two Points
#' @description This function add de distance and duration of the Shortest Path 
#' Between Two Points. Its use the osrmRoute function of osrm library, that build 
#' and send an OSRM API query to get the travel geometry between two points. 
#' This function interfaces the route OSRM service. The principal contribution to 
#' this function it´s yo consider the CRS of the input coordinates, and only output 
#' the distance and time variables of the procedure.
#' @param src_dst Dataframe with four variables: x of source, y of source, x of 
#' destination, y of destination. x and y are plain coordinates in the defined CRS
#' @param crs Coordinate Reference Systems (CRS)
#'
#' @return Return a DataFrame with:
#' \item{src_dst}{The input DataFrame with 2 new variables "distance" in meters 
#' and "duration" in minutes}
#' @export
#' @import osrm
#' @import sp
#' @importFrom curl has_internet
#' @importFrom assertthat assert_that 
#' @references Timothée Giraud, Robin Cura & Matthieu Viry 2017 osrm: Interface 
#' Between R and the OpenStreetMap-Based Routing Service OSRM. 
#' https://CRAN.R-project.org/package=osrm
#' @examples 
#' \dontrun{
#' src_dst <- as.data.frame(cbind(576626, 6143649, 562248, 6142596))
#' a <- byosrmRoute(src_dst, crs = sp::CRS("+init=epsg:32721"))
#' }


byosrmRoute <- function(src_dst, crs){
        assertthat::assert_that(.x = curl::has_internet() && 
                                        getOption("osrm.server") == "https://routing.openstreetmap.de/", 
                                msg = "No internet access was detected. Please check your connection.")
        pop_s <- SpatialPoints(src_dst[ ,1:2], proj4string = crs)## transform pop to spatial object
        centers_s <- SpatialPoints(src_dst[ ,3:4], proj4string = crs)## transform centers to spatial object
        pop_s <- spTransform(pop_s, sp::CRS("+init=epsg:4326"))
        centers_s <- spTransform(centers_s, sp::CRS("+init=epsg:4326"))
        pop1 <- as.data.frame(cbind(1:nrow(src_dst), pop_s@coords))
        centers1 <- as.data.frame(cbind(1:nrow(src_dst), centers_s@coords))
        r <- as.list(NA)
        for (i in 1:nrow(pop1)) {
                tryCatch({
                        r[[i]] <- osrmRoute(src = pop1[i, ], dst = centers1[i, ], 
                                            overview = "full", returnclass = "sp")
                        src_dst[i, "dist"] <- r[[i]]@data$distance * 1000
                        src_dst[i, "time"] <- r[[i]]@data$duration
                }, error = function(e) {cat("ERROR :",conditionMessage(e), "\n")})
        }
        src_dst
}
