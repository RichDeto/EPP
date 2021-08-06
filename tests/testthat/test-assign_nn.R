test_that("assign_nn works", {
        library(osrm)
        pop_epp_nn <- assign_nn(pop_epp[1:20,], centers_epp)
        expect_equal(ncol(pop_epp_nn), 7)
})
