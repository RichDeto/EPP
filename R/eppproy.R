eppproy <- function(pob, m = 5, l = 4, o = 3, g1 = 50, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2, crs = c('CRS("+init=epsg:32721")')) {
        require(sp);require(foreach);require(maptools);require(rgeos);require(rgdal);require(deldir);require(flexclust);library(plyr)
        # Voronoi script modify of "http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/"
        voronoipolygons <- function(x, crs = c('CRS("+init=epsg:32721")')) {
                require(deldir)
                require(sp)
                if (.hasSlot(x, 'coords')) {
                        crds <- x@coords  
                } else crds <- x
                z <- deldir(crds[,1], crds[,2],rw = c(x@bbox[1,1] - (x@bbox[1,1] * 0.05),
                                                      x@bbox[1,2] + (x@bbox[1,2] * 0.05),
                                                      x@bbox[2,1] + (x@bbox[2,1] * 0.05),
                                                      x@bbox[2,2] - (x@bbox[2,2] * 0.05)))#c(366582,858252,6127919,6671739))
                w <- tile.list(z)
                polys <- vector(mode = 'list', length = length(w))
                for (i in seq(along = polys)) {
                        pcrds <- cbind(w[[i]]$x, w[[i]]$y)
                        pcrds <- rbind(pcrds, pcrds[1,])
                        polys[[i]] <- Polygons(list(Polygon(pcrds)), ID = as.character(i))
                }
                SP <- SpatialPolygons(polys,proj4string = crs)
        }
ninos <- pob
clusterizados <- as.list(NA)
j <- 1 #iteration index
n <- 1 #pob remainder
while (j <= m | n >=  1) {
 distancia <- ifelse(j <= l,d1,d2) #modify if you want to try with more distance options
 tam <- ifelse(j <= 0,g1,g2) #modify if you want to try with more capacity options
 k <- ifelse(is.infinite(tam),g2,ceiling(nrow(ninos) / tam*0.75))
 ninos$cluster <- as.factor(cclust(ninos[,1:2],k)@cluster)
 medianax <- as.data.frame(tapply(ninos$x,ninos$cluster,FUN = median)) # coordenada x del centro medio del cluster
 names(medianax) <- c("medianax")
 medianay <- as.data.frame(tapply(ninos$y,ninos$cluster,FUN = median)) # coordenada y del centro medio del cluster
 names(medianay) <- c("medianay")
 ninos <- merge(ninos,medianax,by.x = "cluster",by.y = "row.names") #se agregan las coordenadas de los centros medianos
 ninos <- merge(ninos,medianay,by.x = "cluster",by.y = "row.names") #se agregan las coordenadas de los centros medianos
 ninos$dist <- sqrt((ninos$x - ninos$medianax) ^ 2 + (ninos$y - ninos$medianay) ^ 2) #distancia al centro mediano
 ninos <- ninos[order(ninos$cluster,ninos$dist),]
 lista_cluster <- as.data.frame(sort(unique(ninos$cluster))) # lista de los centros que tienen ni?os asignados
 names(lista_cluster) <- c("cluster")
 lista_cluster$cluster <- row.names(lista_cluster)
 ninos <- merge(ninos,lista_cluster,by = "cluster")
 lista_1 <- vector("list", nrow(lista_cluster))             
 for (i in 1:nrow(lista_cluster)) {
     lista_1[[i]] <- rank(subset(ninos,ninos$cluster == i)[,"dist"],ties.method = "random")
 } # crea una lista de rangos (por distancia) para cada ni?o dentro del cluster de pertenencia 
 orden_dist <- as.data.frame(NULL)
 for (i in 1:length(lista_1)) {
         orden_dist <- rbind(orden_dist,as.data.frame(lista_1[[i]]))
 }
 colnames(orden_dist) <- "orden_dist"
 ninos <- cbind(ninos[order(ninos$cluster,ninos$dist),],orden_dist) # asigna el rango a la base de ni?os
 # ninos$orden_dist_1 <- unlist(lista_1)
 remove(i,lista_1)
 max_n_cl <- as.data.frame(tapply(ninos$orden_dist[ninos$dist <= distancia], ninos$cluster[ninos$dist <= distancia] ,max))
 max_n_cl$cluster <- as.factor(row.names(max_n_cl))
 names(max_n_cl) <- c("max_n_cl","cluster")
 max_n_cl$max_n_cl <- ifelse(is.na(max_n_cl$max_n_cl),1,max_n_cl$max_n_cl)
 ninos <- merge(ninos,max_n_cl,by = "cluster" )
 ninos$tam <- tam
 ninos$a_reasig <- ifelse(ninos$tam %in% c(g1, g2),ifelse(ninos$max_n_cl >= tam & ninos$orden_dist <= tam,0,1),0)
 # aquellos cuyo rango es mayor que la cantidad de cupoos disponibles debe ser reasignado en otro paso
 clusters <- subset(ninos,ninos$a_reasig == 0)
 levels(clusters$cluster) <- droplevels(clusters$cluster)
 clusters$ronda <- as.factor(j) # indica la ronda en la que se asigno al centro correspondiente
 clusterizados[[j]] <- clusters
 remove(clusters)            
 ninos <- subset(ninos,ninos$a_reasig == 1,select = c(x,y,afam))
 n <- length(ninos$x)
 j <- j + 1
}
asignados_clusters <- as.data.frame(NULL)
for (i in 1:length(clusterizados)) {
  asignados_clusters <- rbind(asignados_clusters,as.data.frame(clusterizados[[i]]))
}
asignados_clusters$id <- paste(asignados_clusters$ronda,asignados_clusters$medianax,asignados_clusters$medianay, sep = "_")
asignados_clusters$p_afam <- 0
asignados_clusters$cubre <- 0
asignados_clusters$p_dist <- 0
for (i in unique(asignados_clusters$id)) {
        asignados_clusters[asignados_clusters$id == i,]$cubre <- 
                nrow(asignados_clusters[asignados_clusters$id == i,])
        asignados_clusters[asignados_clusters$id == i,]$p_afam <- 
                round(sum(asignados_clusters[asignados_clusters$id == i,]$afam) / 
                              nrow(asignados_clusters[asignados_clusters$id == i,]),2)
        asignados_clusters[asignados_clusters$id == i,]$p_dist <-
                mean(asignados_clusters[asignados_clusters$id == i,]$dist)
}
centros_clusters <- subset(asignados_clusters,duplicated(asignados_clusters$id) == F,
                           select = c(id,x,y,p_afam,medianax,medianay,p_dist,cubre,ronda))
asignados_clusters <- subset(asignados_clusters,select = c(id,x,y,afam,medianax,medianay,dist,ronda))
centros_clusters_s <- SpatialPointsDataFrame(SpatialPoints(centros_clusters[,2:3],crs), 
                                               centros_clusters, match.ID = TRUE)
asignados_clusters_s <- SpatialPointsDataFrame(SpatialPoints(asignados_clusters[,2:3],crs),
                                              asignados_clusters, match.ID = TRUE)
eppproy.output <- list("new_centers" = centros_clusters_s, "new_assign" = asignados_clusters_s)
return(eppproy.output)
}
