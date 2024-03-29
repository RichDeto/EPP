#' Evaluation of proximity coverage by a program and estimate new services to attend the uncover population.
#' @description Assigns the elements from pob to the centers by n+m iterations, according to the capacity and distance/s of radium of each center. The output is a list that contains four data.frames: pop have the unassigned population, centers has the centers that still have capacity available, used_capacity have the center's occuped capacity and assigned has the population assigned to the centers. The assignation of points to centers is based in proximity and optimization criteria (maximum distance and center's capacity).
#' 
#' @param pop Population to attend (dataframe with three variables: x, y, and weight). Each element represents the position and identity of a population's member. x and y represents plain coordinates in the selected Coordinate Reference System.
#' @param centers Existing centers of the program (dataframe with four variables: x, y, id, capacity). Each element represents the position, identity and capacity of a center. x and y represents plain coordinates in the selected Coordinate Reference System.
#' @param n Total number of iterations with the distance "d1". Default n = 3
#' @param m Number of iteration in which change the distance of radium. If m>n only the first distance is used. Default m = 0
#' @param d1 Radius in meters that each center covers in the firsts "n" iterations. Default d1 = 1000
#' @param d2 Radius in meters that each center covers, the last "m" iterations. Default = d1 * 2
#' @param crs Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721").
#' @param route logical if FALSE the distance is calculated by Pythagorean formula, if TRUE the distance is calculated by "osrmRoute" function of "osrm" Package. Default = FALSE
#'
#' @return Return a LIST with:
#' \item{pop_uncover }{DataFrame of the population still out of coverage; with its "x", "y" and "weight".}
#' \item{pop_assigned }{DataFrame with the population assigned and the corresponding center; with its "x", "y","weight", "id" of the center and the "iteration" of assign.}
#' \item{remaining_capacity }{DataFrame of the centers and its unused capacity; with "x" and "y" of the center, the "id", and the unused "capacity".}       
#' \item{used_capacity }{List of DataFrames with the centers and the info of population covered in each iteration. Each DataFrames have the name of the iteration, and contains the "id", "x" and "y" of the center; and the remaining "capacity" and "used_cap" after the iteration.}
#' @export
#' @references Bivand, R., Keitt, T., Rowlingson, B., Pebesma, E., Sumner, M., Hijmans, R. y Rouault, E. (2015), Bindings for the Geospatial Data Abstraction Library. URL https://cran.r-project.org/web/packages/rgdal/rgdal.pdf
#' Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
#' Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Documento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
#' Farmer, carson (2009) Voronoi polygons with R. URL http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/
#' Leisch, F. y Dimitriadou, E. (2013), Flexible Cluster Algorithms. URL https://cran.r-project.org/web/packages/flexclust/flexclust.pdf
#' Pebesma, E., Bivand, R., Rowlingson, B., Gomez-Rubio, V., Hijmans, R., Sumner, M., MacQueen, D. et al. (2015), Classes and Methods for Spatial Data. URL https://cran.r-project.org/web/packages/sp/sp.pdf
#' R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
#' Turner, R. (2015), Delaunay Triangulation and Dirichlet (Voronoi) Tessellation. URL https://cran.r-project.org/web/packages/deldir/deldir.pdf
#' 
#' @examples
#' exist <- eppexist(pop = pop_epp, 
#'                   centers = centers_epp)
 
eppexist <- function(pop, centers, n = 3, m = 0, d1 = 1000, d2 = d1 * 2, crs = sp::CRS("+init=epsg:32721"), route = FALSE) {
  assigned <- as.list(NA)
  used_capacity <- as.list(NA) 
  dist <- c(rep.int(d1, n), rep.int(d2, m)) ## compiles a vector of distances
  for (i in 1:length(dist)) {
    if (nrow(pop) > 0 & nrow(centers) > 0) {
      iteration <- assignation_exist(pop = pop, centers = centers, d = dist[i], crs = crs, route = route) ## assigns the population to the centers
      pop <- iteration[[1]]
      cov <- iteration[[2]]
      if (nrow(cov) > 0) {
        cov$it <- i 
        cov$dist <- dist[i]
        cov$one <- 1
        cent1 <- merge(centers,
                    data.frame(used_cap = tapply(X = cov$one, INDEX = list(cov$id), FUN = sum)),
                    by.x = "id", by.y = "row.names", all.x = TRUE)
        cent1$used_cap <- ifelse(is.na(cent1$used_cap), 0, cent1$used_cap)
        cent1$capacity <- cent1$capacity - cent1$used_cap
        centers <- subset(cent1, cent1$capacity > 0, select = c(x, y, id, capacity), drop = TRUE) 
        centers <- droplevels(centers)
        used_capacity[[i]] <- cent1
        assigned[[i]] <- cov
        remove(cent1)
      } 
    remove(cov)
    }
  }
  names(used_capacity) <- 1:length(used_capacity)
  list("pop_uncover" = pop, "pop_assigned" = do.call("rbind", assigned)[ ,1:6], "remaining_capacity" = centers, 
       "used_capacity" = used_capacity[!sapply(used_capacity, is.null)])
}
