## DoubleArrayTrie.jl

[![Build Status](https://travis-ci.org/hshindo/DoubleArrayTrie.jl.svg?branch=master)](https://travis-ci.org/hshindo/DoubleArrayTrie.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/github/hshindo/DoubleArrayTrie.jl?branch=master)](https://ci.appveyor.com/project/hshindo/DoubleArrayTrie-jl/branch/master)

This package implements a double-array trie in [Julia](http://julialang.org/).

<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/trie.png" width="250"></p>

## Installation
```julia
julia> Pkg.update()
julia> Pkg.clone("https://github.com/hshindo/DoubleArrayTrie.jl.git")
```

## Double Array
Double-array is a fast implementation that realizes a trie data structure.
Basically, it contains two internal arrays: `base` and `check`.

Roughly speaking, `base` is an offset for child node indices and `check` is a flag to ensure that the child node exsits in a trie.

More specifically, a double-array must keep the following conditions:
* child = `base`[parent] + key
* `check`[child] == parent

<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/doublearray.png" width="500"></p>

In the above example,
* 3 = base[1] + 2
* check[3] == 1
* 4 = base[3] + 4
* check[4] == 3
and so on. Note that `#` indicates undefined.

Looking up a key in a trie takes O(m) time where `m` is the key length.

* Prefix match
Double array can be used for associative array.

## Usage
```julia
using DoubleArrayTrie

trie = DATrie()

```

## References
* Jun-ichi Aoe. An efficient digital search algorithm by using a double-array structure. IEEE Transactions on Software Engineering, Vol. 15, No. 9, pp. 1066-1077, 1989.
