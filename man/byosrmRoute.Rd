% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/byosrmRoute.R
\name{byosrmRoute}
\alias{byosrmRoute}
\title{Add the Shortest Path Between Two Points}
\usage{
byosrmRoute(src_dst, crs)
}
\arguments{
\item{src_dst}{Dataframe with four variables: x of source, y of source, x of 
destination, y of destination. x and y are plain coordinates in the defined CRS}

\item{crs}{Coordinate Reference Systems (CRS)}
}
\value{
Return a DataFrame with:
\item{src_dst}{The input DataFrame with 2 new variables "distance" in meters 
and "duration" in minutes}
}
\description{
This function add de distance and duration of the Shortest Path 
Between Two Points. Its use the osrmRoute function of osrm library, that build 
and send an OSRM API query to get the travel geometry between two points. 
This function interfaces the route OSRM service. The principal contribution to 
this function it´s yo consider the CRS of the input coordinates, and only output 
the distance and time variables of the procedure.
}
\examples{
\donttest{
src_dst <- as.data.frame(cbind(576626, 6143649, 562248, 6142596))
a <- byosrmRoute(src_dst, crs = sp::CRS("+init=epsg:32721"))
}
}
\references{
Timothée Giraud, Robin Cura & Matthieu Viry 2017 osrm: Interface 
Between R and the OpenStreetMap-Based Routing Service OSRM. 
https://CRAN.R-project.org/package=osrm
}
