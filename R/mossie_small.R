## Data for a GLM of mosquito abundance. cx_modestus gives the numbers
## of mosquito larvae collected at a series of locations along streams
## in the UK. depth gives the depth of those streams at those locations.

mossie_small <- data.frame(
  cx_modestus = c(0, 5, 0, 0, 5, 0, 1, 0, 0, 0, 5, 0, 1, 10, 2, 1, 0,
                  0, 0, 6, 0, 0, 0, 0, 0, 5, 6, 5, 0, 0, 0, 0, 0, 0,
                  0, 2, 57, 0, 5, 1, 0, 0, 0, 2, 0, 0, 11, 0, 0, 1,
                  0, 0),
  depth = c(-0.729, 0.889, -0.189, 1.609, -0.729, -0.189, -0.729,
            1.788, -1.52, 1.069, -0.549, 2.328, -0.01, -0.729, -0.01,
            -0.549, -0.01, 0.71, 0.35, -0.729, 2.508, 2.508, -0.729,
            1.788, 0.71, 0.53, -0.909, -0.549, -1.52, 2.328, -0.549,
            1.069, 0.71, 0.889, 1.069, -0.549, -0.729, 3.586, -0.549,
            -0.01, -0.189, 2.867, -0.01, 1.069, 1.609, -1.592, -0.549,
            -0.909, -0.01, 1.069, 2.148, -0.909)
)
