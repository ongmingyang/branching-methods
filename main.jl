include("functions.jl")
include("greedy_one_opt.jl")
include("random_mutation.jl")

# A is arbitrary
n = 500
A = - rand(n,n) + eye(n)
A = A + A'
# (TODO) use a random gaussian
# make symmetric

x = greedy_one_opt(A)
print("Final objective with one_opt method: $x \n")

x = random_mutation(A)
print("Final objective with random_mutation method: $x \n")

print("Timing information\n")
print("==================\n\n")
print("Greedy one opt algorithm: \n")
@time greedy_one_opt(A)
Profile.init(delay=0.0001)
@profile greedy_one_opt(A)
# Profile.print()

print("Timing information\n")
print("==================\n\n")
  print("Random mutation algorithm: \n")
@time random_mutation(A)
Profile.init(delay=0.0001)
@profile random_mutation(A)
# Profile.print()
