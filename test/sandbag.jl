workspace()
using DoubleArray

keys = Vector{Int}[]
vals = AbstractString[]
lines = open(readlines, joinpath(pwd(),"linux.words"))
for l in lines
  l = chomp(l)
  key = [Int(c) for c in l]
  push!(key,0)
  push!(keys, key)
  push!(vals, l)
end
vals

t = DoubleArray.Trie(keys, vals)
for i = 1:length(keys)
  pop!(keys[i])
  a = get(t, keys[i], 0)
  println(a)
end


data = Vector{Int}[]
push!(data, [1,2,3,0])
push!(data, [1,3,4,5,0])
push!(data, [2,1,3,2,0])
push!(data, [2,1,4,0])
values = [1,2]
t = DoubleArray.Trie(data, values)

id = get(t, [1,2,3], 0)


t.nodes
