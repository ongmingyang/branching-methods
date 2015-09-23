# Computes the value of f(x) = x'Ax
#
# @param A is an n*n square matrix
# @param x is a vector of size n
# return f(x) = x'Ax
#
function objective_function(A, x)
  value = x' * A * x 
  # print(x, value[1], "\n")
  return value[1]
end

# Finds a fair estimate for the optimization problem
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
# return x
#
function random_mutation(A)
  n = size(A, 1)
  k = n^2
  x = ones(n)
  best_guess = objective_function(A,x)

  # Mutate x at k random points
  for i=1:k
    mutation_index = rand(1:n)
    x[mutation_index] = -x[mutation_index]
    new_guess = objective_function(A,x)
    if new_guess > best_guess
      best_guess = new_guess 
    else
      x[mutation_index] = -x[mutation_index]
    end
  end
  return x
end

# Finds a fair estimate for the optimization problem
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
# return x
#
function greedy_one_opt(A)
  n = size(A, 1)
  x = ones(n)
  still_guessing = true
  best_guess = objective_function(A,x)
  guess_vector = copy(x)

  while still_guessing
    x = guess_vector
    original_guess = best_guess

    for i=1:length(x)
      x[i] = -x[i]
      new_guess = objective_function(A,x)
      if new_guess > best_guess
        best_guess = new_guess
        guess_vector = copy(x)
      end
      x[i] = -x[i]

      # The algorithm terminates if all mutations in the neighbourhood do not
      # improve the value of f(x)
      if (i == length(x)) && (best_guess == original_guess)
        still_guessing = false
      end
    end

  end

  return x
end

# Prints the value of a vector in a nice format
#
# @param x
# return None
#
function pretty_print(x)
  print(" [\n");
  for i=1:length(x)
    print("  ",x[i],"\n")
  end
  print(" ]\n");
end
