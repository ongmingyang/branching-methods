require("lib/functions.jl")

# Finds a local optimum for the optimization problem with high probability,
#
#     max f(x) = x'Ax
#     s.t. x^2 = 1
#
# By mutating x at one random index at each iteration and picks the value of
# argmax(f(x), f(mutated_x)) for the next iteration.
# 
# The function terminates after k iterations, where k is chosen to be n^2 in
# this particular implementation
# TODO: This algorithm takes forever to terminate, change the termination
# criteria
#
# @param A is a square matrix
# return x'Ax
#
function simulated_annealing(A)
  n = size(A, 1)

  # Temperature is arbitrary
  T = 1

  # Stop evaluating improvements in x after k mutations 
  k = n  # k = n^2 is arbitrary

  x = ones(n)
  current_objective = objective_function(A,x)
  best_guess = current_objective
  best_x = copy(x)

  # Mutate x until k evaluations yield no improvement
  #
  # pre-generate Ax for optimization purposes
  Ax = A * x
  counter = 0
  while counter <= k
    mutation_index = rand(1:n)

    difference = difference_function(A, x, mutation_index, Ax)

    # Escape parameterization
    acceptance_probability = exp(difference/T)

    if rand() < acceptance_probability
      x[mutation_index] *= -1
      current_objective += difference

      # Update the value of Ax for optimization purposes
      e_i = sparsevec([mutation_index => x[mutation_index]], n)
      Ax += A * 2 * e_i

    end

    if current_objective > best_guess
      # Resets the counter and retries the k iterations
      counter = 0
      best_guess = current_objective
      best_x = copy(x)
      T = 1
    else
      counter += 1
      T = exp(-counter)
    end
  end
  return objective_function(A, best_x)
end
