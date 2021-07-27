test_that("clust_it works", {
        clu <- clust_it(pop = pop_epp)
        expect_equal(length(clu), 2)
        expect_error(clust_it(pop = pop_epp, g1 = 50))
})