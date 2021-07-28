test_that("clust_it works", {
        x <- sp::SpatialPoints(centers_epp[ ,1:2])
        centers_voro <- voro_polygon(x)
        expect_s4_class(centers_voro, "SpatialPolygonsDataFrame")
        expect_error(xx <- voro_polygon(centers_epp))
        expect_warning(voro_polygon(x, range.expand = c(0.1, 0.1, 0.1)))
        expect_warning(xx <- voro_polygon(x, bounding.polygon = rgeos::bbox2SP(584647, 6157472, 564216, 6142882)))
})