test_that("buff_voronoi works", {
        buf_centers <- buff_voronoi(centers_epp, id = 'id', w_buff = 1000, crs = sp::CRS("+init=epsg:32721"))
        expect_s4_class(buf_centers, "SpatialPolygonsDataFrame")
})
