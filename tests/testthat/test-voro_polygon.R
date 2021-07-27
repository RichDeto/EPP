test_that("clust_it works", {
        x <- sp::SpatialPoints(centers_epp[ ,1:2])
        centers_voro <- voro_polygon(x)
        expect_s4_class(centers_voro, "SpatialPolygonsDataFrame")
})