# Returns a dense n*n symmetric matrix
# A follows a normal distribution with mean 0 and std 1
#
function not_so_sparse(n)
  A = randn(n,n)
  return A + A'
end

# Returns a sparse symmetric matrix
# Representing a graph with maximum degree k
#
# @param n required to be even
#
function sparse_generate(n)
  # n must be even
  @assert ( n%2 == 0 )

  # k is arbitrary
  k = n

  # Initialize M and A
  M = spzeros(n,n)
  alt = int([i%2 for i=1:n-1])
  zs = int(zeros(n))
  A = Tridiagonal(alt, zs, alt)
  A = sparse(full(A)) # Tridiagonal has no sparse cast

  for i=1:k
    perm = randcycle(n)
    M += A[perm, perm]
  end
  return M
end

