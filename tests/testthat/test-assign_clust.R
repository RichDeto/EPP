test_that("assign_clust works", {
        set.seed(1)
        a <- clust_it(pop_epp)
        a <- assign_clust(clustered = a)
        expect_equal(length(a), 2)
})
