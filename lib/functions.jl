# Computes the value of f(x) = x'Ax
#
# @param A is an n*n symmetric matrix
# @param x is a vector of size n
# return f(x) = x'Ax
#
function objective_function(A, x)
  value = x' * A * x 
  return value[1]
end

# Given f(x) = x'Ax, finds the difference between 
# f(x) and f(x2) where x2 is x mutated at the ith index
#
# The difference between x'Ax and y'Ay is computed as 
# (+-)4 e_i A x + 4 e_i' A e_i
# Given the assumption that A is symmetric
#
# @param A is an n*n symmetric matrix
# @param x is a vector of size n
# @param i is index i
# @param Ax_provided is an optional argument if the caller knows the value of
# A * x beforehand. This argument is used for optimization purposes.
# return f(x2) - f(x)
#
function difference_function(A, x, i, Ax=false)
  n = size(A, 1)
  e_i = sparsevec([i => (-1) * x[i]], n)

  # Generate Ax if caller does not provide
  Ax = (Ax == false ? A * x : Ax)

  difference = 4 * e_i' * Ax + 4 * objective_function(A, e_i)
  return difference[1]
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
