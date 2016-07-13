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

## Double-Array
Double-array is an ordered tree structure that realizes a trie data structure.

It contains two arrays: `base` and `check`.

In double-array, the following conditions must be hold.
* child_id = base[id] + key
* check[child_id] == id

<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/trie_internal.png" width="250"></p>
<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/doublearray.png" width="250"></p>

In the example,
* 2 = base[1] + 1
* check[2] == 1
* 3 = base[2] + 2
* check[3] == 2

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
