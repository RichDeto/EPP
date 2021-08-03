#' Generate a distance matrix for dataframes of more than 100 rows, using osrm functions by nrow(dataframe)/100 of rows, avoiding the record limit of the original osrm function
#' @description Generate a distance matrix for dataframes of more than 100 rows, using osrm functions by nrow(dataframe)/100 of rows. Its use the osrmRoute and osrmTable functions of osrm library, that build and send an OSRM API query to get the travel geometry between two points. 
#' This function interfaces the route OSRM service. The principal contribution to this function it´s to consider avoiding the record limit of the original osrm function.
#' 
#' @param src Dataframe with three variables: id, and a pair of coordinates, or only the pair of coordinates with the "wid" parameter setted FALSE
#' @param dst Dataframe with three variables: and a pair of coordinates, or only the pair of coordinates with the "wid" parameter setted FALSE
#' @param crs Specific coordinates system to transform to the CRS("+init=epsg:4326") needed by osrm library.
#' @param wid If TRUE keeping the "id" of the first column, if FALSE generate an "id" using the nrow function.
#'
#' @return Return a DataFrame with:
#' \item{matriz}{The distance matrix of all the rows of the dataframe}
#' @export
#' @import osrm
#' @references Timothée Giraud, Robin Cura and Matthieu Viry 2017 osrm: Interface Between R and the OpenStreetMap-Based Routing Service OSRM. https://CRAN.R-project.org/package=osrm
#' @keywords spatial osrm
#' @examples 
#' \dontrun{
#' a <- osrm_matrixby100(src = cbind(id = 1:80, pop_epp[1:80, 1:2]),
#'                       dst = cbind(id = 103:135, pop_epp[103:135, 1:2]), 
#'                       crs = sp::CRS("+init=epsg:32721"), wid = TRUE)
#' }

osrm_matrixby100 <- function(src, dst, crs, wid = TRUE){ 
  src_s <- SpatialPoints(if (wid == TRUE) {as.data.frame(src[, 2:3])} else {as.data.frame(src[, 1:2])}, proj4string = crs)
  dst_s <- SpatialPoints(if (wid == TRUE) {as.data.frame(dst[, 2:3])} else {as.data.frame(dst[, 1:2])}, proj4string = crs)
  src_s <- spTransform(src_s, CRS("+init=epsg:4326"))
  dst_s <- spTransform(dst_s, CRS("+init=epsg:4326"))
  if (wid == T) {
    src <- as.data.frame(cbind(src[,1], src_s@coords))
    dst <- as.data.frame(cbind(dst[,1], dst_s@coords))
  }
  if (wid == F) {
    src <- as.data.frame(cbind(1:nrow(src), src_s@coords))
    dst <- as.data.frame(cbind(1:nrow(dst), dst_s@coords))
  }
  l <- ceiling(nrow(src)/90)
  lk <- NA
  for (j in 1:(l + 1)) {
    if (j == 1) lk[j] <- 1
    if (j != 1) lk[j] <- round((nrow(src) / l) * (j - 1)) 
  }
  m <- ceiling(nrow(dst)/100)
  lg <- NA
  for (i in 1:(m + 1)) {
    if (i == 1) lg[i] <- 1
    if (i != 1) lg[i] <- round((nrow(dst) / m) * (i - 1)) 
  }
  matriz <- matrix(nrow = nrow(src), ncol = nrow(dst))
  for (k in 1:(l + 1)) {
    tryCatch({
      for (g in 1:(m + 1)) {
        if (k <= l & g <= m) {matriz[lk[k]:lk[k + 1], lg[g]:lg[g + 1]] <- osrmTable(src = src[lk[k]:lk[k + 1],], dst = dst[(lg[g]):(lg[g + 1]),])$durations}
        if (k != g & k > l) {matriz[lk[k - 1]:lk[k], lg[g]:lg[g + 1]] <- osrmTable(src = src[lk[k - 1]:lk[k],], dst = dst[(lg[g]):(lg[g + 1]),])$durations}
        if (k != g & g > m) {matriz[lk[k]:lk[k + 1], lg[g - 1]:lg[g]] <- osrmTable(src = src[lk[k]:lk[k + 1],], dst = dst[(lg[g - 1]):(lg[g]),])$durations}
        if (k > l & g > m) {matriz[lk[k - 1]:lk[k], lg[g - 1]:lg[g]] <- osrmTable(src = src[lk[k - 1]:lk[k]], dst = dst[(lg[g - 1]):(lg[g]),])$duration}
      }
    }, error = function(e) {cat("ERROR :",conditionMessage(e), "\n")})
  }
  row.names(matriz) <- src[,1]
  colnames(matriz) <- dst[,1]
  matriz
}
