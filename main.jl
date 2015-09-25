include("functions.jl")

# A is arbitrary
n = 100
A = - rand(n,n) + eye(n)
x = greedy_one_opt(A)
print("Final answer with one_opt method: \n")
pretty_print(x)

x = random_mutation(A)
print("Final answer with random_mutation method: \n")
pretty_print(x)

print("Timing information\n")
print("==================\n\n")
print("Greedy one opt algorithm: \n")
@time greedy_one_opt(A)
Profile.init(delay=0.0001)
@profile greedy_one_opt(A)
Profile.print()

print("Timing information\n")
print("==================\n\n")
print("Random mutation algorithm: \n")
@time random_mutation(A)
Profile.init(delay=0.0001)
@profile random_mutation(A)
Profile.print()
