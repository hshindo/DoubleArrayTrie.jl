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
Double-array is a fast implementation that realizes a [trie](https://en.wikipedia.org/wiki/Trie) data structure.
Basically, it contains two internal arrays: `base` and `check`.

Roughly speaking, `base` is an offset value for child node indices and `check` is a flag to ensure that the child node exsits in a trie.

More specifically, a double-array is constructed as the following conditions hold.
* child = base[parent] + key
* check[child] == parent

<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/doublearray.png" width="600"></p>

In the above example,
* 3 = base[1] + 2
* check[3] == 1
* 4 = base[3] + 4
* check[4] == 3

and so on. Note that `#` indicates undefined value.

Looking up a key in a trie takes O(m) time where `m` is the key length.

## Usage
The main type of `DoubleArrayTrie.jl` is `DATrie{T}`.
A type of key is `Vector{Int}` and that of value is `T`.

For simplicity and efficiency, the package only supports _static_ construction, which means keys must be sorted beforehand and `DATrie` does not provide any functions to append/delete key-values.

For key lookup, use `get(trie, key::Vector{Int}, default)` function.

Here is a quick example.
```julia
using DoubleArrayTrie

# Please download "words.txt" from "DoubleArrayTrie/test/words.txt"
lines = open(readlines, "<path>/words.txt")
sort!(lines)

words = map(chomp, lines)
keys = map(w -> [Int(c) for c in w], words)
trie = DATrie(keys, words)

for i = 1:length(words)
  v = get(trie, keys[i], "")
  if v == words[i]
    println(v)
  else
    error("Key not found: $(keys[i]).")
  end
end
```

## References
* Jun-ichi Aoe. An efficient digital search algorithm by using a double-array structure. IEEE Transactions on Software Engineering, Vol. 15, No. 9, pp. 1066-1077, 1989.
