assign_voro <- function(pop, centers, crs) {
        pob_s <- SpatialPoints(pop[ ,1:2], proj4string = crs)## transform pop to spatial object
        centers_s <- SpatialPoints(centers[ ,1:2], crs)## transform centers to spatial object
        VP_centers1 <- voronoipolygons(centers_s, crs)## generate voronoipoligons of centers
        centers$poligono <- over(VP_centers1, centers_s, returnList = FALSE)## assign centers info to voronoipoligons
        ab <- as.data.frame(over(pob_s, VP_centers1))## intersects the population with the voronoi polygons of the centers
        names(ab) <- "poligono"
        pop <- cbind(pop, ab)
        pop <- merge(pop, centers, by = "poligono")
        pop <- rename(pop[ ,!colnames(pop)=="poligono"], c(x.x="x_pop",y.x="y_pop",x.y="x_center",y.y="y_center"))
} 
