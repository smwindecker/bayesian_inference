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
n <- 50

# parameters
int <- 100
coef <- -0.2
sigma <- 20

# predictor data
time <- seq(0, 300, length.out = n)

# put it together
mu_i <- coef*time + int
mass_i <- rnorm(n, mu_i, sigma)

# plot
plot(time, mu_i, ylim = c(0, 100), pch = 20, cex = 0.5)
plot(time, mass_i, ylim = c(0, 100), pch = 20, cex = 0.5)


### Introduction to brms ####

library(brms)

# simulated data
decomp <- data.frame(mass = mass_i, 
                     time = time)

## compare baseline models
f0 <- lm(mass ~ time, decomp)
b0 <- brm(mass ~ time, decomp)

summary(f0)
summary(b0)

### Linear regression ####

## setting up our model
# formula for brms model
b1_formula <- bf(mass ~ time)

# which priors should we define?
get_prior(b1_formula, 
          data = decomp, 
          family = gaussian)

# set weak priors
weakly_informative_priors <- c(
  set_prior('normal(0, 20)', class = 'b', coef = 'time'),
  set_prior('normal(0, 20)', class = 'Intercept'),
  set_prior('normal(0, 50)', class = 'sigma'))

# prior predictive check using sample_prior = 'only' argument
b1_prior1 <- brm(
  b1_formula,
  data = decomp,
  family = gaussian, 
  prior = weakly_informative_priors,
  sample_prior = 'only' # only sample from the priors specified
)

summary(decomp)
pp_check(b1_prior1, prefix = 'ppd', ndraws = 500)

# explore more informative priors
informative_priors <- c(
  set_prior('normal(0, 5)', class = 'b', coef = 'time'),
  set_prior('normal(100, 50)', class = 'Intercept'),
  set_prior('normal(0, 40)', lb = 0, class = 'sigma'))

b1_prior2 <- brm(
  b1_formula,
  data = decomp,
  family = gaussian, 
  prior = informative_priors,
  sample_prior = 'only' # only sample from the priors specified
)

summary(decomp)
pp_check(b1_prior2, prefix = 'ppd', ndraws = 500)

## fitting our model
b1_mod <- brm(
  b1_formula,
  data = decomp,
  family = gaussian, 
  prior = informative_priors,
  sample_prior = TRUE
)


### Model checking and interpretation #####
# summarise model and check convergence
summary(b1_mod)
plot(b1_mod)

# plot the prior-posterior update plot for the intercept
posterior_b1 <- as_draws_df(b1_mod)
dim(posterior_b1)
variables(b1_mod)

library(ggplot2)
ggplot(posterior_b1) +
  geom_density(aes(prior_Intercept), fill="steelblue", color="black",alpha=0.6) +
  geom_density(aes(b_Intercept), fill="#FC4E07", color="black",alpha=0.6) + 
  theme_classic()

# check residuals
res_vals <- residuals(b1_mod)
fitted_vals <- fitted(b1_mod)

plot(fitted_vals[,1], res_vals[,1])

# posterior predictive check
pp_check(b1_mod, ndraws = 500)

# plot conditional effects
plot(conditional_effects(b1_mod), points = TRUE)

# plot credible intervals
mcmc_plot(b1_mod)
mcmc_plot(b1_mod, variable = 'b_time')

# bayesian p-value
library(bayestestR)
p_map(b1_mod)

# predict to new data
time_pred <- data.frame(time = seq(50, 250, length.out = 100))
pred <- predict(b1_mod, 
                newdata = time_pred,
                summary = FALSE) # to show all the posterior samples

### Exercise multiple linear regression and/or GLM ####
## dataset with additional predictor
source('R/decomp_mult.R')
decomp_mult <- create_decomp_mult_data()

## dataset for glm
source('R/mossie_small.R')
