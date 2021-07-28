test_that("byosrmRoute works", {
        library(osrm)
        src_dst <- as.data.frame(cbind(576626, 6143649, 562248, 6142596))
        a <- byosrmRoute(src_dst, crs = sp::CRS("+init=epsg:32721"))
        expect_equal(ncol(a), 6)
})