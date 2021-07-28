test_that("eppproy works", {
        proy <- eppproy(pop = pop_epp)
        expect_equal(class(proy), "list")
        expect_equal(length(proy), 3)
})