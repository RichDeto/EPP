test_that("osrmby100 works", {
        library(osrm)
        a <- osrm_matrixby100(src = cbind(id = 1:80, pop_epp[1:80,1:2]),
                         dst = cbind(id = 103:135, pop_epp[103:135,1:2]), 
                         crs = sp::CRS("+init=epsg:32721"), wid = TRUE)
        expect_type(a, "double")
        b <- osrm_matrixby100(src = cbind(id = 1:80, pop_epp[1:80,1:2]),
                              dst = cbind(id = 103:135, pop_epp[103:135,1:2]), 
                              crs = sp::CRS("+init=epsg:32721"), wid = FALSE)
        expect_type(b, "double")
})
