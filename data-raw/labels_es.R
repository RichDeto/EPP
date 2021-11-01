labels_es <- data.frame(
        en = c("Id center", "Unused capacity", "Capacity", "Weight", "Id center assigned",
               "Iteration", "Distance", "Remaining capacity", "Centers full", 
               "Assigned population", "Uncover population", "Mean weight",
               "Mean distance", "Proposed centers", "Total capacity", "Uncover heatmap"),
        es = c("Id centro", "Capacidad remanente", "Capacidad", "Pondera", "Id centro asignado",
               "Corrida", "Distancia", "Capacidad disponible", "Centros llenos",
               "Pob. asignada", "Pob. no cubierta", "Media variable peso", "Distancia media", 
               "Centros propuestos", "Capacidad total", "Heatmap no cubiertos"),
        stringsAsFactors = FALSE)
usethis::use_data(labels_es, overwrite = TRUE)
