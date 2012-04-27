load("sa.jl")

function rosenbrock(x, y)
  (1 - x)^2 + 100(y - x^2)^2
end

function neighbors(z)
  [rand_uniform(z[1] - 1, z[1] + 1),
   rand_uniform(z[2] - 1, z[2] + 1)]
end
 
simulated_annealing(z -> rosenbrock(z[1], z[2]),
                    [0, 0],
                    neighbors,
                    i -> 1 / log(i),
                    10000,
                    true)

@elapsed for i = 1:5000
  simulated_annealing(z -> rosenbrock(z[1], z[2]),
                      [0, 0],
                      neighbors,
                      i -> 1 / log(i),
                      10000,
                      true)
end
