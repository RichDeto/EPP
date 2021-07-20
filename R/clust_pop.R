#' Function group population for finding best placing of local services
#' @description The function groups the georreferenced population in k clusters (using flexclust::cclust), and provides the median centre for each group and the euclidean distance from each observation to the median centre of its group. 
#' 
#' @param pop Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS
#' @param k Number of desired clusters
#'
#' @return Return a DATAFRAME with:
#' \item{pop$cluster}{Identity of the cluster for each observation}
#' \item{pop$dist}{Distance of each observation to the median centre of the cluster}
#' @export
#' @importFrom flexclust cclust
#' @references Leisch, F. (2006). A Toolbox for K-Centroids Cluster Analysis. Computational Statistics and Data Analysis, 51 (2), 526-544.
#' Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
#' Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
#' R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
#' @examples
#' clust_pop(pop_epp, k = 10)

clust_pop <- function(pop, k){ 
  pop$cluster <- as.factor(flexclust::cclust(pop[ ,1:2], k)@cluster)
  medianx <- data.frame(medianx = as.vector(tapply(pop$x, pop$cluster, FUN = median)))
  mediany <- data.frame(mediany = as.vector(tapply(pop$y, pop$cluster, FUN = median)))
  pop <- merge(pop, medianx, by.x = "cluster", by.y = "row.names") 
  pop <- merge(pop, mediany, by.x = "cluster", by.y = "row.names")
  pop$dist <- sqrt((pop$x - pop$medianx) ^ 2 + (pop$y - pop$mediany) ^ 2) # Euclidean distance to the median center of group 
  pop <- pop[order(pop$cluster, pop$dist), ]  #ordered by distance
}
