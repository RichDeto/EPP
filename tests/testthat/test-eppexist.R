test_that("eppexist works", {
        set.seed(1)
        exist <- eppexist(pop = pop_epp, 
                          centers = centers_epp, 
                          crs = sp::CRS("+init=epsg:32721"))
        expect_equal(class(exist), "list")
        expect_equal(length(exist), 4)
})