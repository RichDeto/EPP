eppxist <- function(pob,centers, n = 3, m = n + 1, a = 1000, b = a * 2, crs = c('CRS("+init=epsg:32721")')) {
        require(sp);require(foreach);require(maptools);require(rgeos);require(rgdal);require(deldir);require(flexclust);require(plyr)
        # Voronoi script modify of "http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/"
        voronoipolygons <- function(x, crs) {
                require(deldir)
                require(sp)
                if (.hasSlot(x, 'coords')) {
                        crds <- x@coords  
                } else crds <- x
                z <- deldir(crds[,1], crds[,2],rw = c(x@bbox[1,1] - (x@bbox[1,1] * 0.05),
                                                      x@bbox[1,2] + (x@bbox[1,2] * 0.05),
                                                      x@bbox[2,1] - (x@bbox[2,1] * 0.05),
                                                      x@bbox[2,2] + (x@bbox[2,2] * 0.05)))
                w <- tile.list(z)
                polys <- vector(mode = 'list', length = length(w))
                for (i in seq(along = polys)) {
                        pcrds <- cbind(w[[i]]$x, w[[i]]$y)
                        pcrds <- rbind(pcrds, pcrds[1,])
                        polys[[i]] <- Polygons(list(Polygon(pcrds)), ID = as.character(i))
                }
                SP <- SpatialPolygons(polys,proj4string = crs)
        }
        cupos_centers <- as.list(NA)
        asignados <- as.list(NA)
        j <- 1
        while (n >= j) {
                pob_s <- SpatialPoints(pob[,1:2],proj4string = crs)## transform pob to spatial object
                centers_s <- SpatialPoints(centers[,1:2],crs)## transform centers to spatial object
                VP_centers1 <- voronoipolygons(centers_s, crs)## generate voronoipoligons of centers
                centers$poligono <- over(VP_centers1,centers_s,returnList = FALSE)## assign centers info to voronoipoligons
                ab <- as.data.frame(over(pob_s,VP_centers1))
                names(ab) <- "poligono"
                pob <- cbind(pob,ab)
                pob <- merge(pob,centers,by = "poligono")
                remove(ab)
                
                pob$dist_exist <- sqrt(((pob$x.x - pob$x.y) ^ 2) + ((pob$y.x - pob$y.y) ^ 2))## distance calc
                d <- ifelse(m > j,a,b)## evaluation distance criteria
                pob$en1000_exist <- ifelse(pob$dist_exist >= d,0,1)
                ninos_sipi <- list(tapply(X = pob$en1000_exist,INDEX = list(pob$sipi),FUN = sum))## pob count by center
                ninos_conteo <- as.data.frame(c(ninos_sipi))
                names(ninos_conteo) <- c("ninos_ex")
                ninos_conteo$sipi <- row.names(ninos_conteo)
                pob <- merge(pob, ninos_conteo,by.x = "sipi", by.y = "sipi", all.x = TRUE, all.y = TRUE)
                pob <- pob[order(pob$sipi, pob$dist_exist),]## order by center & distance
                remove(ninos_conteo)
                lista_sipi <- as.data.frame(sort(unique(pob$sipi))) # list centers with assign pob
                names(lista_sipi) <- c("sipi")
                lista_sipi$nsipi <- row.names(lista_sipi)
                pob <- merge(pob,lista_sipi,by = "sipi")
                lista_1 <- vector("list", nrow(lista_sipi))
                for (i in 1:nrow(lista_sipi)) {
                        lista_1[[i]] <- rank(subset(pob,pob$nsipi == i)[,"dist_exist"],ties.method = "random")
                } ## rank pob by center and distance
                pob$orden_dist <- unlist(lista_1) ## assign rank to pob
                remove(lista_1)
                pob$a_reasig1 <- ifelse(pob$en1000_exist == 1,ifelse(pob$orden_dist <= pob$mat,0,1),1) # pob uncover to reassign
                cubiertos <- subset(pob, pob$a_reasig1 == 0, c(x.x,y.x,afam,sipi),drop = TRUE)
                cubiertos <- droplevels(cubiertos)
                cubiertos$iteration <- as.factor(j)## index iteration
                cubiertos$uno <- 1
                centers1 <- as.data.frame(tapply(X = cubiertos$uno,INDEX = list(cubiertos$sipi), FUN = sum))
                names(centers1) <- "cupos"
                centers1$sipi <- row.names(centers1)
                cupos_centers[[j]] <- centers1 ##pob assign to each center in iteration
                centers1 <- merge(centers,centers1,by = "sipi",all.x = TRUE)
                centers1$cupos <- ifelse(is.na(centers1$cupos),0,centers1$cupos)
                centers1$mat <- centers1$mat - centers1$cupos ## capacity still avaible 
                centers1 <- subset(centers1,centers1$mat > 0,drop = TRUE) ## centers with capacity to next iteration
                centers <- subset(centers1,select = c(x,y,sipi,mat),drop = TRUE)
                centers <- droplevels(centers)
                remove(centers1)
                pob$x <- pob$x.x
                pob$y <- pob$y.x
                pob <- subset(pob,pob$a_reasig1 == 1,select = c(x,y,afam),drop = TRUE)
                asignados[[j]] <- cubiertos
                remove(cubiertos)
                j <- j + 1 #next iteration
        }
        cupos_perdidos <- centers
        no_cubiertos <- pob
        asignados_existentes <- as.data.frame(NULL)### Unlist pop uncover
        for (i in 1:length(asignados)) {
                asignados_existentes <- rbind(asignados_existentes,as.data.frame(asignados[[i]]))
        }
        asignados_existentes <- subset(asignados_existentes,select = c(x.x,y.x,afam,sipi,ronda))
        cupos_cubiertos1 <- as.data.frame(NULL) ### Unlist centers
        for (i in 1:length(cupos_centers)) {
                cupos_cubiertos1 <- rbind(cupos_cubiertos1,as.data.frame(cupos_centers[[i]]))
        }
        cupos_cubiertos <- as.data.frame(tapply(X = cupos_cubiertos1$cupos,INDEX = list(cupos_cubiertos1$sipi), FUN = sum))
        names(cupos_cubiertos) <- "capacity"
        cupos_cubiertos$sipi <- row.names(cupos_cubiertos)
        eppxist.output <- list("unused_capacity" = cupos_perdidos, "pop_uncovered" = no_cubiertos , "pop_assigned" = asignados_existentes, "centers_covered" = cupos_cubiertos)
        return(eppxist.output)
}
