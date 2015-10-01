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

# Notes

1. This method can be generalized into a simulated annealing method
2. When A is a sparse matrix, this algorithm works significantly faster!

# Plots

The plots are available at https://plot.ly/~mingy/
