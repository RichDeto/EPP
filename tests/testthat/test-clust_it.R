test_that("clust_it works", {
        set.seed(1)
        clu <- clust_it(pop = pop_epp)
        expect_equal(length(clu), 2)
        expect_error(clust_it(pop = pop_epp, g1 = 50))
})