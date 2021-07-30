test_that("clust_it works", {
        set.seed(1)
        exist <- eppexist(pop = pop_epp, 
                          centers = centers_epp, 
                          crs = sp::CRS("+init=epsg:32721"))
        aa <- leafepp(exist, type = "exist", crs = sp::CRS("+init=epsg:32721"))
      
        ## In case of eppproy
        
        proy <- eppproy(pop = exist$pop_uncover)
        leafepp(proy, type = "proy", crs = sp::CRS("+init=epsg:32721"))
          
})