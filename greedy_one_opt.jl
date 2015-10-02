require("lib/functions.jl")

# Finds a local optimum for the optimization problem
#
#     max f(x) = x'Ax
#     s.t. x^2 = 1
#
# by systematically mutating x pointwise to attain the best possible value of
# f(x) amongst its neighbours
#
# The function terminates after f(x) > f(y) for all y in neighbourhood(x) and
# returns the discovered value of x
#
# @param A is a square matrix
# return x'Ax
#
function greedy_one_opt(A)
  n = size(A, 1)
  x = ones(n)

  # Pre-generate Ax for optimization purposes
  Ax = A * x

  best_guess = objective_function(A,x)
  guess_index = 1

  while true

    original_guess = best_guess

    for i=1:n
      difference = difference_function(A, x, i, Ax)

      if best_guess < original_guess + difference
        best_guess = original_guess + difference
        guess_index = i
      end
    end

    # The algorithm terminates if all mutations in the neighbourhood do not
    # improve the value of f(x)
    if best_guess == original_guess
      break
    end

    # Update the value for x
    x[guess_index] *= -1

    # Update the value of Ax for optimization purposes
    Ax += 2 * A * sparsevec([guess_index => x[guess_index]],n)

  end

  return best_guess
end

