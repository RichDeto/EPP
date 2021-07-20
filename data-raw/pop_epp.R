## code to prepare `pop_epp` dataset goes here
pop_epp <- data.frame(x = sample(560000:585000,500),
                  y = sample(6136000:6160000,500),
                  weight = runif(500, min = 0, max = 1))
usethis::use_data(pop_epp, overwrite = TRUE)
