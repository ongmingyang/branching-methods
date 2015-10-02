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
  T = 5000

  # Stop evaluating improvements in x after k mutations 
  k = n  # k = n is arbitrary

  x = ones(n)
  current_objective = objective_function(A,x)

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
      e_i = spzeros(n,1)
      e_i[mutation_index] = (-1) * x[mutation_index]
      Ax += A * 2 * e_i

      # Resets the counter and retries the k iterations
      counter = 0
    else
      counter += 1
      T = T > 1 ? T * (1-1/n) : 1
    end
  end
  return current_objective
end
