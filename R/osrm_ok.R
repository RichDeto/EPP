#' Verify osrm server
#' @description This function helps to fail gratefully if OSRM service is down.
#' @export
#' @import osrm
#' @importFrom curl has_internet
#' @importFrom assertthat assert_that 
#' 

osrm_ok <- function(){
        assertthat::assert_that(.x = curl::has_internet() , 
                                msg = "Sorry, no internet access was detected. Please check your connection.")
        tryCatch({httr::http_error("https://routing.openstreetmap.de/")
                TRUE
        },
        error = function(e) {
                message("Sorry, the osrm server may down, please try in other moment.")
                FALSE
        })
}