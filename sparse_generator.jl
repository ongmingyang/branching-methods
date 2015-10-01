# Returns a dense n*n symmetric matrix
#
function not_so_sparse(n)
  A = -rand(n,n) + eye(n)
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

