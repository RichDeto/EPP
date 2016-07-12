# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

eppxist <- function(pob,centers,n,m,a,b) {
        require(sp)

        cupos_centers <- as.list(NA)
        asignados <- as.list(NA)
        j <- 1 # iteracion inicial

        #n <- 3 # iteraciones totales
        #m <- iteraci?n a partir de la que se usa el segundo umbral de distancia
        #a <- distancia umbral para las primeras iteraciones (n > m)
        #b <- distancia umbral para las iteraciones a partir de m (n <= m)
        # ITERACIONES
        while (n >= j) {
                ## CREACION DEL OBJETO ESPACIAL CON LOS NI?OS
                pob_s <- SpatialPoints(pob[,1:2],proj4string = CRS("+init=epsg:32721"))
                ## ENLACE ESPACIAL DE NI?OS CON LOS VORONOIS INICIALES Y C?LCULO DE NI?OS CUBIERTOS POR LA OFERTA ACTUAL
                centers_s <- SpatialPoints(centers[,1:2],CRS("+init=epsg:32721"))
                VP_centers1 <- voronoipolygons(centers_s)
                #ENLACE ESPACIAL
                centers$poligono <- over(VP_centers1,centers_s,returnList = FALSE)
                # el resultado es igual al row.names de centros! lo dejo para tener la misma variable para el merge
                ab <- as.data.frame(over(pob_s,VP_centers1))
                names(ab) <- "poligono"
                pob <- cbind(pob,ab)
                pob <- merge(pob,centers,by = "poligono")
                remove(ab)
                # C?LCULO DE DISTANCIAS ENTRE LOS NI?OS Y LOS CENTROS
                pob$dist_exist <- sqrt(
                        ((pob$x.x - pob$x.y) ^ 2) +
                                ((pob$y.x - pob$y.y) ^ 2))
                #DICOT?MICA DE DISTANCIA (MENOR O IGUAL A 1000 M)
                d <- ifelse(m > j,a,b) #criterio de distancia dependiente de la iteraci?n
                pob$en1000_exist <- ifelse(pob$dist_exist >= d,0,1)
                #CONTEO DE NI?OS POR CADA CENTRO DENTRO DEL UMBRAL DE DISTANCIA
                ninos_sipi <- list(tapply(X = pob$en1000_exist,
                                          INDEX = list(pob$sipi),
                                          FUN = sum)) # conteo de ni?os asignados a cada centro educativo
                ninos_conteo <- as.data.frame(c(ninos_sipi))
                names(ninos_conteo) <- c("ninos_ex")
                ninos_conteo$sipi <- row.names(ninos_conteo)
                pob <- merge(pob, ninos_conteo,
                                by.x = "sipi", by.y = "sipi", all.x = TRUE, all.y = TRUE)
                # carga del dato de cantidad de ni?os por centro en la base de ni?os
                pob <- pob[order(pob$sipi, pob$dist_exist),]
                # se ordena la base por centro de pertenencia y por distancia al mismo
                remove(ninos_conteo)
                # C?LCULO DE NI?OS CUBIERTOS
                lista_sipi <- as.data.frame(sort(unique(pob$sipi))) # lista de los centros que tienen ni?os asignados
                names(lista_sipi) <- c("sipi")
                lista_sipi$nsipi <- row.names(lista_sipi)
                pob <- merge(pob,lista_sipi,by = "sipi")
                lista_1 <- vector("list", nrow(lista_sipi))
                for (i in 1:nrow(lista_sipi)) {
                        lista_1[[i]] <- rank(subset(pob,pob$nsipi == i)[,"dist_exist"],ties.method = "random")
                } # crea una lista de rangos (por distancia) para cada ni?o dentro de su centro de pertenencia
                pob$orden_dist <- unlist(lista_1) # asigna el rango a la base de ni?os
                remove(lista_1)
                pob$a_reasig1 <- ifelse(pob$en1000_exist == 1,
                                           ifelse(pob$orden_dist <= pob$mat,0,1),1)
                # aquellos cuyo rango es mayor que la cantidad de cupos disponibles debe ser reasignado en otro paso

                ## C?LCULO DE CUPOS UTILIZADOS
                cubiertos <- subset(pob, pob$a_reasig1 == 0, c(x.x,y.x,afam,sipi),drop = TRUE)
                cubiertos <- droplevels(cubiertos)
                cubiertos$ronda <- as.factor(j) # indica la ronda en la que se asigno al centro correspondiente
                cubiertos$uno <- 1
                centers1 <- as.data.frame(tapply(X = cubiertos$uno,INDEX = list(cubiertos$sipi), FUN = sum))
                names(centers1) <- "cupos"
                centers1$sipi <- row.names(centers1)
                cupos_centers[[j]] <- centers1 #CUPOS DE CADA CENTRO CUBIERTOS EN CADA PASO
                centers1 <- merge(centers,centers1,by = "sipi",all.x = TRUE)
                centers1$cupos <- ifelse(is.na(centers1$cupos),0,centers1$cupos)
                centers1$mat <- centers1$mat - centers1$cupos #esto corresponde al saldo no cubierto
                centers1 <- subset(centers1,centers1$mat > 0,drop = TRUE) # se continua con los centros que a?n tienen saldo
                centers <- subset(centers1,select = c(x,y,sipi,mat),drop = TRUE)
                centers <- droplevels(centers)
                remove(centers1)
                ## NI?OS NO CUBIERTOS
                pob$x <- pob$x.x
                pob$y <- pob$y.x
                pob <- subset(pob,pob$a_reasig1 == 1,select = c(x,y,afam),drop = TRUE)
                ## LISTA DE NI?OS YA CUBIERTOS, UN OBJETO DE LA LISTA POR CADA PASO
                asignados[[j]] <- cubiertos
                remove(cubiertos)
                j <- j + 1 #cuenta la iteraci?n
        }
        cupos_perdidos <- centers
        no_cubiertos <- pob

        ###Desenlistado de los menores cubiertos
        asignados_existentes <- as.data.frame(NULL)
        for (i in 1:length(asignados)) {
                asignados_existentes <- rbind(asignados_existentes,as.data.frame(asignados[[i]]))
        }
        asignados_existentes <- subset(asignados_existentes,select = c(x.x,y.x,afam,sipi,ronda))

        ###Desenlistado de los Centros
        cupos_cubiertos1 <- as.data.frame(NULL)
        for (i in 1:length(cupos_centers)) {
                cupos_cubiertos1 <- rbind(cupos_cubiertos1,as.data.frame(cupos_centers[[i]]))
        }
        cupos_cubiertos <- as.data.frame(tapply(X = cupos_cubiertos1$cupos,INDEX = list(cupos_cubiertos1$sipi), FUN = sum))
        names(cupos_cubiertos) <- "cupos"
        cupos_cubiertos$sipi <- row.names(cupos_cubiertos)

        #limpiar el ambiente
        remove(i,j,n,m,a,b,d,lista_sipi,centers,centers_s,VP_centers1,
               pob_s,ninos_sipi,pob,asignados,cupos_centers,cupos_cubiertos1)
}
