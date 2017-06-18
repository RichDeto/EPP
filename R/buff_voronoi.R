buff_voronoi <- function(x, id = 'id', w_buff = 1000, crs = CRS("+init=epsg:32721")) {
        SPP <- SpatialPoints(x[,1:2],crs)
        if (.hasSlot(SPP, 'coords')) {
                crds <- SPP@coords  
        } else crds <- SPP
        z <- deldir(crds[,1], crds[,2],rw = c(SPP@bbox[1,1] - (SPP@bbox[1,1] * 0.05),
                                              SPP@bbox[1,2] + (SPP@bbox[1,2] * 0.05),
                                              SPP@bbox[2,1] - (SPP@bbox[2,1] * 0.05),
                                              SPP@bbox[2,2] + (SPP@bbox[2,2] * 0.05)))
        w <- tile.list(z)
        polys <- vector(mode = 'list', length = length(w))
        for (i in seq(along = polys)) {
                pcrds <- cbind(w[[i]]$x, w[[i]]$y)
                pcrds <- rbind(pcrds, pcrds[1,])
                polys[[i]] <- Polygons(list(Polygon(pcrds)), ID = as.character(i))
        }
        SP <- SpatialPolygons(polys,proj4string = crs)
        SPD <- SpatialPolygonsDataFrame(SP,x,match.ID = FALSE)
        SPDT <- SpatialPointsDataFrame(SPP,x,match.ID = FALSE)
        # id = paste0("SPDT$",id) 
        B_SPP <- gBuffer(SPDT,byid = T,width = w_buff)
        a <- gIntersection(B_SPP,SPD,byid = T,drop_lower_td = T) 
        a <- SpatialPolygonsDataFrame(a,as.vector(subset(over(a,SPDT,returnList = F))),match.ID = F) 
        y<-unionSpatialPolygons(a,a@data[,id]) 
        b <- as.data.frame(c(1:length(y)))
        for (i in 1:length(y)) {
                b[i,1] <- y@polygons[[i]]@ID
        }
        names(b) <- id
        buf_voro <- SpatialPolygonsDataFrame(y,b,match.ID = F)
}  
