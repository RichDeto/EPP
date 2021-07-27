test_that("clust_it works", {
        a <- clust_pop(pop_epp, k = 10)
        expect_equal(ncol(a), 7)
})