test_that("clust_it works", {
        a <- assign_voro(pop_epp, centers_epp, crs = sp::CRS("+init=epsg:32721"))
        expect_equal(ncol(a), 7)
        expect_error(a <- assign_voro(pop_epp, centers = rbind(centers_epp, centers_epp[ 1:3,]), 
                         crs = sp::CRS("+init=epsg:32721")))
})