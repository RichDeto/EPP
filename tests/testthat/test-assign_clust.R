test_that("assign_clust works", {
        a <- clust_it(pop_epp)
        a <- assign_clust(clustered = a)
        expect_equal(length(a), 2)
})