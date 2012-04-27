simulated_annealing <- function(cost,
                                s0,
                                neighbor,
                                temperature = function (i) {1 / log(i)},
                                iterations = 10000,
                                keep_best = TRUE)
{  
  # Set our current state to the specified intial state.
  s <- s0
  
  # Set the best state we've seen to the intial state.
  best_s <- s0
  
  # We always perform a fixed number of iterations.
  for (i in 1:iterations)
  {
    # Find the proper temperature at time i.
    t <- temperature(i)
    
    # Randomly generate a neighbor of our current state.
    s_n <- neighbor(s)
    
    # Evaluate the cost function.
    y <- cost(s)
    y_n <- cost(s_n)
    
    if (y_n <= y)
    {
      # We always move to superior states.
      s <- s_n
    }
    else
    {
      # We probabilistically move to inferior states.
      p <- exp(- ((y_n - y) / t))
      
      if (runif(1) <= p)
      {
        s <- s_n
      }
      else
      {
        s <- s
      }
    }

    if (cost(s) < cost(best_s))
    {
      best_s <- s
    }
  }
  
  # Return the best state or the last state we've seen.
  if (keep_best)
  {
    return(best_s)
  }
  else
  {
    return(s)
  }
}
