library(rgdal)
library(sp)

test_that("multiplication works", {
        src_dst <- as.data.frame(cbind(576626, 6143649, 562248, 6142596))
        expect_warning((a <- byosrmRoute(src_dst, sp::CRS("+init=epsg:32721"))))
        expect_equal(ncol(a), 6)
})
