function rand_uniform(a, b)
  a + rand()*(b - a)
end

function simulated_annealing(cost::Function,
                             s0::Any,
                             neighbor::Function,
                             temperature::Function,
                             iterations::Int64,
                             keep_best::Bool)
  
  # Set our current state to the specified intial state.
  s = s0
  
  # Set the best state we've seen to the intial state.
  best_s = s0
  
  # We always perform a fixed number of iterations.
  for i = 1:iterations
    
    # Find the proper temperature at time i.
    t = temperature(i)
    
    # Randomly generate a neighbor of our current state.
    s_n = neighbor(s)
    
    # Evaluate the cost function.
    y = cost(s)
    y_n = cost(s_n)
    
    if y_n <= y
      # We always move to superior states.
      s = s_n
    else
      # We probabilistically move to inferior states.
      p = exp(- ((y_n - y) / t))
      
      if rand() <= p
        s = s_n
      else
        s = s
      end
    end

    if cost(s) < cost(best_s)
      best_s = s
    end
  end
  
  # Return the best state or the last state we've seen.
  if keep_best
    best_s
  else
    s
  end
end
