% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assignation_exist.R
\name{assignation_exist}
\alias{assignation_exist}
\title{Function to assign population to centers of services}
\usage{
assignation_exist(pop, centers, d, crs, route = FALSE)
}
\arguments{
\item{pop}{Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS}

\item{centers}{Centers of services (dataframe with four variables: x, y, id, and capacity) x and y are plain coordinates in the defined CRS}

\item{d}{Maximum distance at which the center may provide service in meters}

\item{crs}{Coordinates reference system of pop and centers}

\item{route}{logical if FALSE the distance is calculated by Pythagorean formula, if TRUE the distance is calculated by "osrmRoute" function of "osrm" Package. Default = FALSE}
}
\value{
Return a LIST with:
    \item{new_centers }{Centers to cover the population}
    \item{new_assign }{Population with the center assigned}
}
\description{
Function to assign population to centers of services, based in proximity, maximum radius and nominal capacity of the centers. The capacity and maximum radius are defined a priori based on policies' objectives
}
\examples{
assignation_exist(pop_epp, centers_epp, d = 1000, crs = sp::CRS("+init=epsg:32721"), route = FALSE)
}
