test_that("eppproy works", {
        set.seed(1)
        proy <- eppproy(pop = pop_epp)
        expect_equal(class(proy), "list")
        expect_equal(length(proy), 3)
})