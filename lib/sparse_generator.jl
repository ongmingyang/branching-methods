# Returns a dense n*n symmetric matrix
# A follows a normal distribution with mean 0 and std 1
#
function not_so_sparse(n)
  A = zeros(n,n)
  A = randn!(A)
  return A + A'
end

# Returns a sparse symmetric matrix
#
function sparse_generate(n)
  # k is arbitrary
  k = n
  M = spzeros(n,n)
  A = speye(n)

  for i=1:k
    M += A[randcycle(n), randcycle(n)]
  end
  return M
end

