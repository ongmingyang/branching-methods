require("lib/functions.jl")

# Finds a local optimum for the optimization problem with high probability,
# TODO: quantify high probability?
#
#     max f(x) = x'Ax
#     s.t. x^2 = 1
#
# By mutating x at one random index at each iteration and picks the value of
# argmax(f(x), f(mutated_x)) for the next iteration.
# 
# The function terminates after k iterations, where k is chosen to be n^2 in
# this particular implementation
#
# @param A is a square matrix
# return x'Ax
#
function random_mutation(A)
  n = size(A, 1)
  x = ones(n)
  best_guess = objective_function(A,x)

  # Stop evaluating improvements in x after k mutations 
  k = n  # k = n is arbitrary

  # Mutate x until k evaluations yield no improvement
  #
  # pre-generate Ax for optimization purposes
  Ax = A * x
  counter = 0
  while counter <= k
    mutation_index = rand(1:n)

    difference = difference_function(A, x, mutation_index, Ax)

    if difference > 0
      x[mutation_index] *= -1
      best_guess += difference

      # Update the value of Ax for optimization purposes
      Ax += A * 2 * sparsevec([mutation_index => x[mutation_index]],n)

      # Resets the counter and retries the k iterations
      counter = 0
    else
      counter += 1
    end
  end
  return best_guess
end
