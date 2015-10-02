Methods involved
================

# Greedy one opt

Finds a local optimum for the optimization problem

```
     max f(x) = x'Ax
     s.t. x^2 = 1
```

by systematically mutating x pointwise to attain the best possible value of f(x) amongst its neighbours

The function terminates after `f(x) > f(y)` for all y in neighbourhood(x) and returns the discovered value of x

Notes: To avoid evaluating f(x) at each step of procedure, we compute the difference `(+-)4 e_i A x + 4 e_i' A e_i`

This doesn't actually yield significant performance improvement with an empirical performance benchmark, even with memoization of Ax. I intend to investigate this further.

# Random mutation

Finds a local optimum for the optimization problem with high probability,

```
     max f(x) = x'Ax
     s.t. x^2 = 1
```

By mutating x at one random index at each iteration and picks the value of `argmax(f(x), f(mutated_x))` for the next iteration.
 
The function terminates after `k` iterations, where `k` is chosen to be `n^2` in this particular implementation

# Simulated annealing

Finds a local optimum for the optimization problem with high probability,

```
     max f(x) = x'Ax
     s.t. x^2 = 1
```

By mutating x at one random index at each iteration with some probability determined by an acceptance probability function. 
 
The function terminates if `k` iterations do not yield a better objective than the best objective found so far. 


Matrix generators
=================

# Not so sparse matrix generator

This generator creates a symmetric matrix with entries belonging to a gaussian distribution of mean 0 and standard deviation 1.

# Sparse matrix generator

Returns the sum of k random permutations of I. This matrix is symmetric with row
and column sums equal to k.

Other details
============

1. When A is a sparse matrix, the maximizers work significantly faster!

# Plots

The plots are available at https://plot.ly/~mingy/
