#' Function to assign population to centers of services
#' @description Creates centres of service based on the spatial clusterization of population.
#' 
#' @param pop Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS
#' @param m Number of iteration rounds. Default 5
#' @param l Number of iteration rounds with the first group size (g1). Default 4
#' @param g1 Size of the groups for the first l iterations. Default 50
#' @param g2 Size of the groups for the last m-l iterations. Default g1 * 0.5
#' @param d1 Distance range of service for the first iterations. Default 1000
#' @param d2 Second distance range of service. Default d1 * 2
#' @param crs Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721")
#'
#' @return Return a LIST with:
#' \item{centros_clusters_s}{SpatialPointsDataFrame of the new centres created}
#' \item{asigned_clusters_s}{SpatialPointsDataFrame of the population covered by the new centres created}
#' @export
#' @references Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121- 128. http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
#' Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
#' R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
#' @author Detomasi, Richard & Botto, German 
#' @keywords spatial clusters
#' @examples 
#' proy <- eppproy(pop_epp)

eppproy <- function(pop, m = 5, l = 4, g1 = 5, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2, crs = CRS("+init=epsg:32721")) {
  assigned <- assign_clust(clust_it(pop, m = m, l = l, g1 = g1, g2 = g2, d1 = d1, d2 = d2)[[1]])
  eppproy.output <- list(centros_clusters_s <- SpatialPointsDataFrame(SpatialPoints(assigned[[1]][ ,2:3], crs), 
                                                                       assigned[[1]], match.ID = TRUE), 
                          asigned_clusters_s <- SpatialPointsDataFrame(SpatialPoints(assigned[[2]][ ,2:3], crs),
                                                                       assigned[[2]], match.ID = TRUE))
} 
