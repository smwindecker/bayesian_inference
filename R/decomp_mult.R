create_decomp_mult_data <- function () {
  
  int <- 100
  coef_time <- -0.2
  coef_temp <- 5
  sigma <- 20
  
  n <- 50
  time <- rep(seq(0, 300, length.out = n), 3)
  site <- rep(c('A', 'B', 'C'), each = n)
  temp <- c(rnorm(n, 22, 3), rnorm(n, 25, 3), rnorm(n, 28, 5))
  
  mu_i <- coef_time*time + coef_temp*temp + int
  mass_i <- rnorm(n*3, mu_i, sigma)
  
  decomp_mult <- data.frame(time = time, 
                            temp = temp, 
                            site = site, 
                            mass = mass_i)
  decomp_mult
  
}

decomp_mult <- create_decomp_mult_data()
