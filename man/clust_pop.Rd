% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clust_pop.R
\name{clust_pop}
\alias{clust_pop}
\title{Function group population for finding best placing of local services}
\usage{
clust_pop(pop, k)
}
\arguments{
\item{pop}{Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS}

\item{k}{Number of desired clusters}
}
\value{
Return a DATAFRAME with:
\item{pop$cluster}{Identity of the cluster for each observation}
\item{pop$dist}{Distance of each observation to the median center of the cluster}
}
\description{
The function groups the georeferenced population in k clusters (using flexclust::cclust), and provides the median center for each group and the euclidean distance from each observation to the median center of its group.
}
\examples{
clust_pop(pop_epp, k = 10)
}
\references{
Leisch, F. (2006). A Toolbox for K-Centroids Cluster Analysis. Computational Statistics and Data Analysis, 51 (2), 526-544.
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Documento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
}
