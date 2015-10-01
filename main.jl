using Plotly

include("functions.jl")
include("greedy_one_opt.jl")
include("random_mutation.jl")
include("sparse_generator.jl")

n = 100
I = 10
# A = sparse_generate(n)
A = not_so_sparse(n)
# (TODO) use a random gaussian

x = greedy_one_opt(A)
print("Final objective with one_opt method: $x \n")
hist1 = Float64[x]

hist2 = Float64[]
for i=1:I
  x = random_mutation(A)
  print("Final objective with random_mutation method: $x \n")
  push!(hist2,x)
end
data = [
  [
    "x" => hist2,
    "type" => "histogram"
  ], [
    "x" => hist1,
    "type" => "histogram"
  ]
]

layout = ["barmode" => "stacked"]

response = Plotly.plot(data, [
  "layout" => layout,
  "filename" => "Histogram of optimum values",
  "fileopt" => "overwrite"
])
plot_url = response["url"]

print("Timing information\n")
print("==================\n\n")
print("Greedy one opt algorithm: \n")
@time greedy_one_opt(A)
# Profile.init(delay=0.0001)
# @profile greedy_one_opt(A)
# Profile.print()

print("Timing information\n")
print("==================\n\n")
print("Random mutation algorithm: \n")
@time random_mutation(A)
# Profile.init(delay=0.0001)
# @profile random_mutation(A)
# Profile.print()
