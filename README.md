## DoubleArrayTrie.jl
Double Array is a data structure for trie structure implementation.
Trie (a.k.a. radix tree or prefix tree) is an ordered tree structure as the following illustration.

<p align="center"><img src="https://github.com/hshindo/DoubleArray.jl/blob/master/trie.png" width="250"></p>

Looking up a key in a trie takes O(m) time where `m` is the key length.
* Prefix match
Double array can be used for associative array.

## Usage
```julia
using DoubleArrayTrie

trie = Trie()

```

## References
* Jun-ichi Aoe. An efficient digital search algorithm by using a double-array structure. IEEE Transactions on Software Engineering, Vol. 15, No. 9, pp. 1066-1077, 1989.
