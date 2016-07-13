## DoubleArrayTrie.jl

[![Build Status](https://travis-ci.org/hshindo/DoubleArrayTrie.jl.svg?branch=master)](https://travis-ci.org/hshindo/DoubleArrayTrie.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/github/hshindo/DoubleArrayTrie.jl?branch=master)](https://ci.appveyor.com/project/hshindo/DoubleArrayTrie-jl/branch/master)

This package implements a double-array trie in [Julia](http://julialang.org/).
Double-array is a fast implementation of trie data structure.
Trie is an ordered tree structure and can be used for dictionary-lookup.

<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/trie.png" width="250"></p>

## Installation
```julia
julia> Pkg.update()
julia> Pkg.clone("https://github.com/hshindo/DoubleArrayTrie.jl.git")
```

## Double-Array
Double-array contains two arrays: `base` and `check`.
Given node id, the following conditions must be hold.
* child_id = base[id] + key
* check[child_id] == id

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
