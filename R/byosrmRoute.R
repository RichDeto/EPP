byosrmRoute <- function(src_dst, crs){
        pop_s <- SpatialPoints(src_dst[ ,1:2], proj4string = crs)## transform pop to spatial object
        centers_s <- SpatialPoints(src_dst[ ,3:4], proj4string = crs)## transform centers to spatial object
        if (crs != CRS("+init=epsg:4326")){
                pop_s <- spTransform(pop_s, CRS("+init=epsg:4326"))
                centers_s <- spTransform(centers_s, CRS("+init=epsg:4326"))
        }
        pop1 <- as.data.frame(cbind(1:nrow(src_dst), pop_s@coords))
        centers1 <- as.data.frame(cbind(1:nrow(src_dst), centers_s@coords))
        r <- as.list(NA)
        for (i in 1:nrow(pop1)){
                r[[i]] <- osrmRoute(src = pop1[i, ], dst = centers1[i, ], overview = "full", sp = T)
                src_dst[i, "dist"] <- r[[i]]@data$distance * 1000
                src_dst[i, "time"] <- r[[i]]@data$duration
        }
}
