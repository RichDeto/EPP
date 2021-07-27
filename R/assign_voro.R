#' Function to assign population to centers of services by Voronois
#' @description Function to process the results from EPP::assignation_exist
#' 
#' @param pop DataFrame of the population, with x and y as first two variables, to assign to each centre by Voronois Polygons. (x and y are plain coordinates in the defined CRS)
#' @param centers DataFrame of the centers, with x and y as first two variables, to assign the population by Voronois Polygons. (x and y are plain coordinates in the defined CRS)
#' @param crs Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721")
#'
#' @return DataFrame with the variables of the pop DataFrame and all the variables of the center who corresponds by its Voronois Polygons
#' @export
#' @references Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
#' Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
#' R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
#' @author Detomasi, Richard & Botto, German
#' @importFrom plyr rename
#' @import sp
#' @examples
#' assign_voro(pop_epp, centers_epp, crs = sp::CRS("+init=epsg:32721"))
#' @keywords spatial cluster

assign_voro <- function(pop, centers, crs) {
        if (sum(duplicated(paste(centers$x, centers$y))) > 1) {
                stop("Your centers dataset have ovelapings, please use group_over() function.")
        }
        pob_s <- SpatialPoints(pop[ ,1:2], proj4string = crs)## transform pop to spatial object
        centers_s <- SpatialPoints(centers[ ,1:2], crs)## transform centers to spatial object
        suppressWarnings(VP_centers1 <- voro_polygon(centers_s))#, crs)## generate voronoipoligons of centers
        centers$poligono <- over(VP_centers1, centers_s, returnList = FALSE)## assign centers info to voronoipoligons
        VP_centers1@data$poligono <- over(VP_centers1, centers_s, returnList = FALSE)## assign centers info to voronoipoligons
        poligono <- as.data.frame(over(pob_s, VP_centers1, returnList = FALSE))[,"poligono"] ## intersects the population with the voronoi polygons of the centers
        pop <- cbind(pop, poligono)
        pop <- merge(pop, centers, by = "poligono")
        pop <- plyr::rename(pop[ ,!colnames(pop) == "poligono"], 
                            c(x.x = "x_pop", y.x = "y_pop", x.y = "x_center", y.y = "y_center"))
}
