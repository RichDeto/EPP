#' leafepp
#'
#' @param x List obtained from eppexist or eppproy
#' @param type Character "exist" or "proy" depending of input structure
#' @param crs Coordinate Reference Systems (CRS).
#' @param ... leaflet options and parameters
#'
#' @return leaflet
#' @export
#' @import leaflet
#' @import leaflet.extras
#' @importFrom dplyr '%>%'
#' @examples
#' ## In case of eppexist
#' 
#' exist <- eppexist(pop = pop_epp, 
#'                   centers = centers_epp, 
#'                   crs = sp::CRS("+init=epsg:32721"))
#' l_epp_exist <- leafepp(exist, type = "exist", crs = sp::CRS("+init=epsg:32721"))
#' 
#' ## In case of eppproy
#' 
#' proy <- eppproy(pop = exist$pop_uncover)
#' l_epp_proy <- leafepp(proy, type = "proy", crs = sp::CRS("+init=epsg:32721"))

leafepp <- function(x, type, crs, ...) {
        if (type == "exist") {
                #### bases ####
                centers <- SpatialPointsDataFrame(SpatialPoints(x$remaining_capacity[ ,1:2], crs), 
                                                  x$remaining_capacity, match.ID = TRUE) %>% 
                        spTransform(CRS = CRS("+init=epsg:4326"))
                assigned <- SpatialPointsDataFrame(SpatialPoints(x$pop_assigned[ ,1:2], crs), 
                                                   x$pop_assigned, match.ID = TRUE) %>% 
                        spTransform(CRS = CRS("+init=epsg:4326"))
                uncover <- SpatialPointsDataFrame(SpatialPoints(x$pop_uncover[ ,1:2], crs), 
                                                  x$pop_uncover, match.ID = TRUE) %>% 
                        spTransform(CRS = CRS("+init=epsg:4326"))
                #### Labels ####
                etiq_center <- paste( sep = "<br/>",
                                    paste0("<b> Id center: ", as.character(centers$id),"</b>"),
                                    paste0("<b> Used capacity: </b>", as.character(centers$used_cap)))
                etiq_assigned <- paste( sep = "<br/>",
                                    paste0("<b> Weight: ", as.character(assigned$weight),"</b>"),
                                    paste0("<b> Id center assigned: </b>", as.character(assigned$id)),
                                    paste0("<b> Iteration: </b>", as.character(assigned$it)),
                                    paste0("<b> Dist: </b>", as.character(assigned$dist)))
                etiq_uncover <- paste( sep = "<br/>",
                                    paste0("<b> Weight: ", as.character(uncover$weight),"</b>"))
                #### Leaflet ####
                leaflet(width = "100%", height = "500", padding = 0) %>%
                        # Ahora generamos un groupo de base
                        addTiles(group = "OSM (default)") %>%
                        addProviderTiles("Esri.WorldImagery", group = "Satelital") %>%
                        addProviderTiles(providers$CartoDB.Positron, group = "Positron") %>%
                        # Generamos el grupo de capas
                        addCircles(data = centers, color = "Black", opacity = 1, fillColor = "red",
                                   weight = 7, group = "Centers", popup = etiq_center) %>%
                        addCircles(data = assigned, color = "#762a83", opacity = 1, 
                                   group = "Assigned population", popup = etiq_assigned) %>%
                        addCircles(data = uncover, color = "#4575b4", opacity = 1, 
                                   group = "Uncover population", popup = etiq_uncover) %>%
                        addHeatmap(data = uncover, blur = 10, max = 0.05, radius = 5, 
                                   group = "Uncover heatmap") %>%
                        # Agregamos controles para las capas
                        addLayersControl(baseGroups = c("OSM (default)", "Satelital", "Positron"),
                                         overlayGroups = c("Centers", "Assigned population", 
                                                           "Uncover population", "Uncover heatmap"),
                                         options = layersControlOptions(collapsed = T)) %>%
                        # Agragamos la leyenda
                        addLegend("bottomleft", colors = c("black", "#762a83", "#4575b4"), opacity = 1,
                                  labels = c("Centers", "Assigned population", "Uncover population"))  %>%
                        addFullscreenControl(position = "topleft", pseudoFullscreen = FALSE) %>%
                        addDrawToolbar() %>% hideGroup(c("Centers", "Assigned population", 
                                                         "Uncover population", "Uncover heatmap"))
        }
        if (type == "proy") {
                #### bases ####
                centers <- x$centros_clusters %>% spTransform(CRS = CRS("+init=epsg:4326"))
                assigned <- x$assigned_clusters %>% spTransform(CRS = CRS("+init=epsg:4326"))
                uncover <- x$unassigned %>% spTransform(CRS = CRS("+init=epsg:4326"))
                #### Labels ####
                etiq_center <- paste( sep = "<br/>",
                                      paste0("<b> Id center: ", as.character(centers$id),"</b>"),
                                      paste0("<b> Capacity: </b>", as.character(centers$cubre)),
                                      paste0("<b> Mean weight: </b>", as.character(centers$weight)),
                                      paste0("<b> Mean distance: </b>", as.character(centers$p_dist)))
                etiq_assigned <- paste( sep = "<br/>",
                                        paste0("<b> Weight: ", as.character(assigned$weight),"</b>"),
                                        paste0("<b> Id center assigned: </b>", as.character(assigned$id)),
                                        paste0("<b> Iteration: </b>", as.character(assigned$round)),
                                        paste0("<b> Dist: </b>", as.character(assigned$dist)))
                etiq_uncover <- paste( sep = "<br/>",
                                       paste0("<b> Weight: ", as.character(uncover$weight),"</b>"))
                #### Leaflet ####
                leaflet(width = "100%", height = "500", padding = 0) %>%
                        # Ahora generamos un groupo de base
                        addTiles(group = "OSM (default)") %>%
                        addProviderTiles("Esri.WorldImagery", group = "Satelital") %>%
                        addProviderTiles(providers$CartoDB.Positron, group = "Positron") %>%
                        # Generamos el grupo de capas
                        addCircles(data = centers, color = "black", opacity = 1, weight = 5,
                                   group = "Centers", popup = etiq_center) %>%
                        addCircles(data = assigned, color = "#762a83", opacity = 1, 
                                   group = "Assigned population", popup = etiq_assigned) %>%
                        addCircles(data = uncover, color = "#4575b4", opacity = 1, 
                                   group = "Uncover population", popup = etiq_uncover) %>%
                        addHeatmap(data = uncover, blur = 10, max = 0.05, radius = 5, 
                                   group = "Uncover heatmap") %>%
                        # Agregamos controles para las capas
                        addLayersControl(baseGroups = c("OSM (default)", "Satelital", "Positron"),
                                         overlayGroups = c("Centers", "Assigned population", 
                                                           "Uncover population", "Uncover heatmap"),
                                         options = layersControlOptions(collapsed = T)) %>%
                        # Agragamos la leyenda
                        addLegend("bottomleft", colors = c("bLack", "#762a83", "#4575b4"), opacity = 1,
                                  labels = c("Centers", "Assigned population", "Uncover population"))  %>%
                        addFullscreenControl(position = "topleft", pseudoFullscreen = FALSE) %>%
                        addDrawToolbar() %>% hideGroup(c("Centers", "Assigned population", 
                                                         "Uncover population", "Uncover heatmap"))
        } else {
                stop("The type has to match some of the valid values: exist or proy")
        }
}
        