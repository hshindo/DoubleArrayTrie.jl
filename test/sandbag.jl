workspace()
using DoubleArray

data = Vector{Int}[]
push!(data, [1,2,3,0])
push!(data, [1,3,4,5,0])
push!(data, [2,1,3,2,0])
push!(data, [2,1,4,0])
t = DoubleArray.Trie(data)

t.nodes
