#' Simulated Population in Uruguay.
#'
#' A dataset containing the coords and other attributes of 500 individuals.
#'
#' @format A data frame with 500 rows and 3 variables:
#' \describe{
#'   \item{x}{x coords in EPSG:31721 CRS}
#'   \item{y}{y coords in EPSG:31721 CRS}
#'   \item{weight}{weight variable to analyze}
#' }
"pop_epp"


#' Simulated Centers of attention in Uruguay.
#'
#' A dataset containing the coords and other attributes of 10 centers of attention.
#'
#' @format A data frame with 10 rows and 4 variables:
#' \describe{
#'   \item{x}{x coords in EPSG:31721 CRS}
#'   \item{y}{y coords in EPSG:31721 CRS}
#'   \item{id}{id of the center}
#'   \item{capacity}{capacity of the centers}
#' }
"centers_epp"

#' pop
#' @name pop
pop <- NULL

#' centers
#' @name centers
centers <- NULL


#' Labels to translate leafepp maps.
#'
#' A dataset containing the labels to translate leafepp maps.
#'
#' @format A data frame with 16 rows and 2 variables:
#' \describe{
#'   \item{en}{English labels}
#'   \item{es}{Spanish labels}
#' }
"labels_es"