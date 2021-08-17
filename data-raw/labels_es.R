labels_es <- data.frame(
        en = c("Id center", "Unused capacity", "Capacity", "Weight", "Id center assigned",
               "Iteration", "Distance", "Remaining capacity", "Centers full", 
               "Assigned population", "Uncover population", "Mean weight",
               "Mean distance", "Proposed centers", "Total capacity", "Uncover heatmap"),
        es = c("Id centro", "Capacidad remanente", "Capacidad", "Pondera", "Id centro asignado",
               "Iteración", "Distancia", "Capacidad disponible", "Centros llenos",
               "Población asignada", "Población no cubierta", "ponderación media",
               "Distancia media", "Centros propuestos", "Capacidad total", "Heatmap no cubiertos"),
        stringsAsFactors = FALSE
)

usethis::use_data(labels_es, overwrite = TRUE)
