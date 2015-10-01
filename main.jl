require("lib/sparse_generator.jl")
require("lib/plots.jl")
require("lib/functions.jl")
require("greedy_one_opt.jl")
require("random_mutation.jl")

n = 100
I = 50
# A = sparse_generate(n)
A = not_so_sparse(n)
# (TODO) use a random gaussian

plot = Plot()

x = greedy_one_opt(A)
# print("Final objective with one_opt method: $x \n")
hist1 = Float64[x]
plot.add(hist1, "Greedy 1-OPT")

hist2 = Float64[]
for i=1:I
  x = random_mutation(A)
  # print("Final objective with random_mutation method: $x \n")
  push!(hist2,x)
end
plot.add(hist2, "Random Mutation")

url = plot.upload()
print("URL for plot here: $url\n\n")

print("Timing information\n")
print("==================\n")
print("Greedy one opt algorithm: \n")
@time greedy_one_opt(A)
# Profile.init(delay=0.0001)
# @profile greedy_one_opt(A)
# Profile.print()

print("Timing information\n")
print("==================\n")
print("Random mutation algorithm: \n")
@time random_mutation(A)
# Profile.init(delay=0.0001)
# @profile random_mutation(A)
# Profile.print()
