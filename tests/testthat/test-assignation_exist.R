test_that("assignation_exist works", {
        a <- assignation_exist(pop_epp, centers_epp, d = 1000, 
                          crs = sp::CRS("+init=epsg:32721"), route = FALSE)
        expect_equal(class(a), "list")
        expect_equal(length(a), 2)
        library(osrm)
        b <- assignation_exist(pop_epp[1:89,], centers_epp, d = 1000, 
                               crs = sp::CRS("+init=epsg:32721"), route = TRUE)
        expect_equal(class(b), "list")
        expect_equal(length(b), 2)
})