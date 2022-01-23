test_that("assign_nn works", {
        library(osrm)
        pop_epp_nn <- assign_nn(x = pop_epp[1:2,], y = centers_epp)
        expect_equal(ncol(pop_epp_nn), 7)
        expect_error(assign_nn(pop_epp[1:2,], centers_epp, y.id = "fid"))
})
