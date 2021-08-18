test_that("leafepp works", {
        set.seed(1)
        exist <- eppexist(pop = pop_epp, 
                          centers = centers_epp, 
                          crs = sp::CRS("+init=epsg:32721"))
        aa <- leafepp(x = exist, t = "exist", crs = sp::CRS("+init=epsg:32721"))
        expect_equal(length(aa), 8)
        expect_error(leafepp(x = exist, t = "e", crs = sp::CRS("+init=epsg:32721")))
        ## In case of eppproy
        proy <- eppproy(pop = exist$pop_uncover)
        bb <- leafepp(proy, t = "proy", crs = sp::CRS("+init=epsg:32721"))
        expect_equal(length(bb), 8)
        proy <- eppproy(pop = exist$pop_uncover, g2 = 5)
        cc <- leafepp(proy, t = "proy", crs = sp::CRS("+init=epsg:32721"))
        expect_equal(length(cc), 8)
})
