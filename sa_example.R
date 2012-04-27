source("sa.R")

rosenbrock <- function(x, y)
{
  (1 - x)^2 + 100 * (y - x^2)^2
}

neighbors <- function(z)
{
  c(runif(1, z[1] - 1, z[1] + 1),
    runif(1, z[2] - 1, z[2] + 1))
}
 
simulated_annealing(function (z) {rosenbrock(z[1], z[2])},
                    c(0, 0),
                    neighbors,
                    function (i) {1 / log(i)},
                    10000,
                    TRUE)

start.time <- Sys.time()

for (i in 1:5000)
{
  simulated_annealing(function (z) {rosenbrock(z[1], z[2])},
                      c(0, 0),
                      neighbors,
                      function (i) {1 / log(i)},
                      10000,
                      TRUE)
}

start.time <- Sys.time()

(end.time - start.time) / 5000
