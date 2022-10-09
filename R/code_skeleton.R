### Simulating data ####

rnorm(n = 10)
rnorm(10, 5, 5)

## set.seed() ensures reproducibility of our random number 

set.seed(1)
rnorm(10)
set.seed(1)
rnorm(10)
set.seed(1)

## simulate a linear model
# mass_i ~ N(mu_i, sigma2)
# mu_i = coef*time_i + int

# number of data points

# parameters

# predictor data

# put it together

# plot
plot(time, mu_i, ylim = c(0, 100), pch = 20, cex = 0.5)
plot(time, mass_i, ylim = c(0, 100), pch = 20, cex = 0.5)


### Introduction to brms ####

library(brms)

# simulated data

## compare baseline models

# summarise

### Linear regression ####

## setting up our model
# formula for brms model

# which priors should we define?

# set weak priors

# prior predictive check using sample_prior = 'only' argument

# explore more informative priors

## fitting our model

### Model checking and interpretation #####
# summarise model and check convergence



# plot the prior-posterior update plot for the intercept



library(ggplot2)
ggplot(posterior_b1) +
  geom_density(aes(prior_Intercept), fill="steelblue", color="black",alpha=0.6) +
  geom_density(aes(b_Intercept), fill="#FC4E07", color="black",alpha=0.6) + 
  theme_classic()

# check residuals

# posterior predictive check

# plot conditional effects

# plot credible intervals

# bayesian p-value
library(bayestestR)

# predict to new data

### Exercise multiple linear regression and/or GLM ####
## dataset with additional predictor
source('R/decomp_mult.R')
decomp_mult <- create_decomp_mult_data()

## dataset for glm
source('R/mossie_small.R')
