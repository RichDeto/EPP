test_that("clust_it works", {
        a <- group_over(rbind(centers_epp, centers_epp[ 1:3,]))
        expect_equal(nrow(a), 10)
})