include("functions.jl")

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
  still_guessing = true
  best_guess = objective_function(A,x)
  guess_index = 1

  while still_guessing
    x[guess_index] = -x[guess_index]
    original_guess = best_guess

    for i=1:n
      difference = difference_function(A, x, i)

      if best_guess < original_guess + difference
        best_guess = original_guess + difference
        guess_index = i
      end

      # The algorithm terminates if all mutations in the neighbourhood do not
      # improve the value of f(x)
      if (i == n) && (best_guess == original_guess)
        still_guessing = false
      end
    end

  end

  return best_guess
end

