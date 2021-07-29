#' #' leafepp
#' #'
#' #' @param x List obtained from eppexist or eppproy
#' #' @param type Character "exist" or "proy" depending of input structure
#' #' @param ... leaflet options and parameters
#' #'
#' #' @return leaflet
#' #' @export 
#' #' @import leaflet
#' #' @import leaflet.extras
#' #' @examples
#' leafepp <- function(x, type, ...) {
#'         if (type = "exist") {
#'                 centers <- exist$used_capacity
#'                 assigned <- exist$pop_assigned
#'                 uncover <- exist$pop_uncover
#'                 
#'                 
#'                 #### Etiquetas ####
#'                 etiq_center <- paste( sep = "<br/>",
#'                                     paste0("<b> Id center: ", as.character(centers$id),"</b>"),
#'                                     paste0("<b> Capacity: </b>", as.character(centers$capacity)),
#'                                     paste0("<b> Used capacity: </b>", as.character(centers$used_cap)))
#'                 
#'                 etiq_assigned <- paste( sep = "<br/>",
#'                                     paste0("<b> Weight: ", as.character(assigned$weight),"</b>"),
#'                                     paste0("<b> Id center assigned: </b>", as.character(assigned$id)),
#'                                     paste0("<b> it: </b>", as.character(assigned$it)),
#'                                     paste0("<b> dist: </b>", as.character(assigned$dist)))
#'                 
#'                 etiq_uncover <- paste( sep = "<br/>",
#'                                     paste0("<b> Weight: ", as.character(uncover$weight),"</b>"))
#'                 
#'                 #### Visualizador ####
#'                 leaflet(width = "100%", height = "500", padding = 0) %>%
#'                         # Ahora generamos un groupo de base 
#'                         addTiles(group = "OSM (default)") %>%
#'                         addProviderTiles("Esri.WorldImagery", group = "Satelital") %>%
#'                         addProviderTiles(providers$CartoDB.Positron, group = "Claro") %>%
#'                         # Generamos el grupo de capas 
#'                         addCircles(data = c_inau, color = "#5ab4ac", opacity = 1, weight = 5, group = "Centros INAU", popup = etiq_inau) %>%
#'                         addCircles(data = c_anep, color = "#d8b365", opacity = 1, weight = 5, group = "Centros ANEP", popup = etiq_anep) %>%
#'                         addCircles(data = jardines_mec , color = "#8c510a", opacity = 1, weight = 5, group = "Jardines Privados", popup = etiq_jard) %>%
#'                         addCircles(data = asist, color = "#762a83", opacity = 1, group = "Niños 0 a 3 AFAM-TUS asiste") %>%
#'                         addCircles(data = no_asist, color = "#4575b4", opacity = 1, group = "Niños 0 a 3 AFAM-TUS no asiste") %>%
#'                         addHeatmap(data = ninos, blur = 10, max = 0.05, radius = 5, group = "heatmap") %>% 
#'                         # Agregamos controles para las capas
#'                         addLayersControl(baseGroups = c("OSM (default)", "Satelital", "Claro"), 
#'                                          overlayGroups = c("Centros INAU", "Centros ANEP", "Jardines Privados", "Niños 0 a 3 AFAM-TUS asiste",
#'                                                            "Niños 0 a 3 AFAM-TUS no asiste", "heatmap"),
#'                                          options = layersControlOptions(collapsed = T)) %>%
#'                         # Agragamos la leyenda
#'                         addLegend("bottomleft", colors = c("#5ab4ac","#d8b365","#8c510a","#762a83", "#4575b4"), opacity = 1,
#'                                   labels = c("Centros INAU", "Centros ANEP", "Jardines Privados", "Niños 0 a 3 AFAM-TUS asiste", 
#'                                              "Niños 0 a 3 AFAM-TUS no asiste"))  %>% 
#'                         addFullscreenControl(position = "topleft", pseudoFullscreen = FALSE) %>% 
#'                         addDrawToolbar() %>% hideGroup(c("Centros INAU", "Centros ANEP", "Jardines Privados",  "Niños 0 a 3 AFAM-TUS asiste",
#'                                                          "Niños 0 a 3 AFAM-TUS no asiste", "heatmap"))
#'                 
#'                 
#'         } 
#'         if (type = "proy") {
#'                 centers 
#'         } else {
#'                 stop("the type has to match some of the valid values")
#'         }
#' }
        