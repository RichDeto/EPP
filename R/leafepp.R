#' leafepp
#' @description template of leaflet map for {eppexist} or {eppproy} outputs
#' @param x List obtained from eppexist or eppproy
#' @param t Character "exist" or "proy" depending of input structure
#' @param crs Coordinate Reference Systems (CRS).
#' @param leng Lenguage of labels. Available english ("en" ) and spanish ("es"). Default "es"
#' @param ... leaflet options and parameters
#'
#' @return leaflet
#' @export
#' @import sf
#' @import leaflet
#' @import leaflet.extras
#' @importFrom dplyr '%>%' left_join transmute
#' @examples
#' ## In case of eppexist
#' 
#' exist <- eppexist(pop = pop_epp, 
#'                   centers = centers_epp, 
#'                   crs = sp::CRS("+init=epsg:32721"))
#' l_epp_exist <- leafepp(exist, t = "exist", crs = sp::CRS("+init=epsg:32721"))
#' 
#' ## In case of eppproy
#' 
#' proy <- eppproy(pop = exist$pop_uncover)
#' l_epp_proy <- leafepp(proy, t = "proy", crs = sp::CRS("+init=epsg:32721"))

leafepp <- function(x, t, crs, leng = "es", ...) {
        lb <- EPP::labels_es
        if (t == "exist") {
                #### bases ####
                centers <- sf::st_as_sf(x$remaining_capacity %>% 
                                                left_join(x$used_capacity[[1]] %>% 
                                                                  transmute(id, "total" = capacity + used_cap), 
                                                          by = "id"), 
                                        coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                centers_full <- sf::st_as_sf(x$used_capacity[[1]] %>% filter(!id %in% centers$id),
                                             coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                assigned <- sf::st_as_sf(x$pop_assigned, coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                uncover <- sf::st_as_sf(x$pop_uncover, coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                #### Labels ####
                etiq_center <- paste( sep = "<br/>",
                                      paste0("<b> ", lb[1, leng], ": ", as.character(centers$id),"</b>"),
                                      paste0("<b> ", lb[2, leng], ": </b>", as.character(centers$capacity)),
                                      paste0("<b> ", lb[15, leng], ": ", as.character(centers$total),"</b>"))
                etiq_center_full <- paste( sep = "<br/>",
                                      paste0("<b> ", lb[1, leng], ": ", as.character(centers$id),"</b>"),
                                      paste0("<b> ", lb[3, leng], ": </b>", 
                                             as.character(centers_full$capacity + centers_full$used_cap)))
                etiq_assigned <- paste( sep = "<br/>",
                                        paste0("<b> ", lb[4, leng], ": ", as.character(assigned$weight),"</b>"),
                                        paste0("<b> ", lb[5, leng], ": </b>", as.character(assigned$id)),
                                        paste0("<b> ", lb[6, leng], ": </b>", as.character(assigned$it)),
                                        paste0("<b> ", lb[7, leng], ": </b>", as.character(assigned$dist)))
                etiq_uncover <- paste( sep = "<br/>",
                                       paste0("<b> ", lb[4, leng], ": ", as.character(uncover$weight),"</b>"))
                #### Leaflet ####
                l <- leaflet(width = "100%", height = "500", padding = 0) %>%
                        addTiles(group = "OSM (default)") %>%
                        addProviderTiles("Esri.WorldImagery", group = "Satelital") %>%
                        addProviderTiles(providers$CartoDB.Positron, group = "Positron") %>%
                        addCircles(data = centers, opacity = 1, color = "red",
                                   weight = 7, group = lb[8, leng], popup = etiq_center) %>%
                        addCircles(data = centers_full, opacity = 1, color = "yellow",
                                   weight = 7, group = lb[9, leng], popup = etiq_center_full) %>%
                        addCircles(data = assigned, color = "#762a83", opacity = 1, 
                                   group = lb[10, leng], popup = etiq_assigned) %>%
                        addCircles(data = uncover, color = "#4575b4", opacity = 1, 
                                   group = lb[11, leng], popup = etiq_uncover) %>%
                        addHeatmap(data = uncover, blur = 10, max = 0.05, radius = 5, 
                                   group = lb[16, leng]) %>%
                        # Agregamos controles para las capas
                        addLayersControl(baseGroups = c("OSM (default)", "Satelital", "Positron"),
                                         overlayGroups = c(lb[c(8:11, 16), leng]),
                                         options = layersControlOptions(collapsed = T)) %>%
                        # Agragamos la leyenda
                        addLegend("bottomleft", colors = c("red", "yellow", "#762a83", "#4575b4"), opacity = 1,
                                  labels = c(lb[8:11, leng]))  %>%
                        addSearchOSM() %>% 
                        addFullscreenControl(position = "topleft", pseudoFullscreen = FALSE) %>%
                        addDrawToolbar() %>% hideGroup(c(lb[c(8:11, 16), leng]))
        }
        if (t != "exist" & t == "proy") {
                #### bases ####
                centers <- sf::st_as_sf(x$centros_clusters, coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                if(length(unique(centers$cubre)) > 1){
                        pal <- colorFactor(palette = c('#A4A9AA', 'Black'), domain = centers$cubre)
                }
                assigned <- sf::st_as_sf(x$assigned_clusters, coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                uncover <- sf::st_as_sf(x$unassigned, coords = c("x", "y"), crs = crs) %>% 
                        sf::st_transform(4326)
                #### Labels ####
                etiq_center <- paste( sep = "<br/>",
                                      paste0("<b> ", lb[1, leng], ": ", as.character(centers$id),"</b>"),
                                      paste0("<b> ", lb[3, leng], ": </b>", as.character(centers$cubre)),
                                      paste0("<b> ", lb[12, leng], ": </b>", as.character(centers$weight)),
                                      paste0("<b> ", lb[13, leng], ": </b>", as.character(centers$p_dist)))
                etiq_assigned <- paste( sep = "<br/>",
                                        paste0("<b> ", lb[4, leng], ": ", as.character(assigned$weight),"</b>"),
                                        paste0("<b> ", lb[5, leng], ": </b>", as.character(assigned$id)),
                                        paste0("<b> ", lb[6, leng], ": </b>", as.character(assigned$round)),
                                        paste0("<b> ", lb[7, leng], ": </b>", as.character(assigned$dist)))
                etiq_uncover <- paste( sep = "<br/>",
                                       paste0("<b> ", lb[4, leng], ": ", as.character(uncover$weight),"</b>"))
                #### Leaflet ####
                l <- leaflet(width = "100%", height = "500", padding = 0) %>%
                        # Ahora generamos un groupo de base
                        addTiles(group = "OSM (default)") %>%
                        addProviderTiles("Esri.WorldImagery", group = "Satelital") %>%
                        addProviderTiles(providers$CartoDB.Positron, group = "Positron") %>%
                        # Generamos el grupo de capas
                        addCircles(data = assigned, color = "#762a83", opacity = 1, 
                                   group = lb[10, leng], popup = etiq_assigned) %>%
                        addCircles(data = uncover, color = "#4575b4", opacity = 1, 
                                   group = lb[11, leng], popup = etiq_uncover) %>%
                        addHeatmap(data = uncover, blur = 10, max = 0.05, radius = 5, 
                                   group = lb[16, leng]) %>%
                        # Agregamos controles para las capas
                        addLayersControl(baseGroups = c("OSM (default)", "Satelital", "Positron"),
                                         overlayGroups = c(lb[c(14,10:11, 16), leng]),
                                         options = layersControlOptions(collapsed = T)) %>% addSearchOSM() %>% 
                        addFullscreenControl(position = "topleft", pseudoFullscreen = FALSE) %>%
                        addDrawToolbar() %>% hideGroup(c(lb[c(14,10:11, 16), leng]))
                        # Agragamos la leyenda
                        
                if (length(unique(centers$cubre)) == 1){
                        l <- l %>% addCircles(data = centers, color = "black", opacity = 1, 
                                              weight = 5, group = lb[14, leng], popup = etiq_center) %>% 
                                addLegend("bottomleft", colors = c("Black", "#762a83", "#4575b4"), opacity = 1,
                                          labels = c(lb[c(14,10:11), leng]))
                        } else {
                                l <- l %>% addCircles(data = centers, color = ~pal(cubre), opacity = 1, 
                                                      weight = 5, group = lb[14, leng], popup = etiq_center) %>%
                                        addLegend("bottomleft", colors = c("Black", "#A4A9AA", "#762a83", "#4575b4"), 
                                                  opacity = 1,
                                                  labels = c(paste0(lb[14, leng], " (n=", unique(centers$cubre)[1], ")"),
                                                             paste0(lb[14, leng], " (n=", unique(centers$cubre)[2], ")"),
                                                             lb[c(10:11), leng]))   
                        } 
        } 
        if (!t %in% c("exist", "proy")) {
                stop("The {t} has to match some of the valid values: exist or proy")
        }
        l
}
        