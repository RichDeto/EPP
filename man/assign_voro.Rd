% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assign_voro.R
\name{assign_voro}
\alias{assign_voro}
\title{Function to assign population to centers of services by Voronoi}
\usage{
assign_voro(pop, centers, crs)
}
\arguments{
\item{pop}{DataFrame of the population, with x and y as first two variables, to assign to each center by Voronoi Polygons. (x and y are plain coordinates in the defined CRS)}

\item{centers}{DataFrame of the centers, with x and y as first two variables, to assign the population by Voronoi Polygons. (x and y are plain coordinates in the defined CRS)}

\item{crs}{Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721")}
}
\value{
DataFrame with the variables of the pop DataFrame and all the variables of the center who corresponds by its Voronoi Polygons
}
\description{
Function to process the results from EPP::assignation_exist
}
\examples{
assign_voro(pop_epp, centers_epp, crs = sp::CRS("+init=epsg:32721"))
}
\references{
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Documento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
}
\author{
Detomasi, Richard & Botto, German
}
\keyword{cluster}
\keyword{spatial}
