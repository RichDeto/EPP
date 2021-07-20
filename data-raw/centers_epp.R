## code to prepare `pop_epp` dataset goes here
centers_epp <- data.frame(x = sample(560000:585000,10),
                          y = sample(6136000:6160000,10),
                          id = 1:10,
                          capacity = sample(5:10,10,replace = TRUE))
usethis::use_data(centers_epp, overwrite = TRUE)
