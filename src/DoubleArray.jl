module DoubleArray

# base: offset for child node, i.e., child = parent.base + key
# check: parent id
immutable Node
  base::Int
  check::Int
end

isused(n::Node) = n.check > 0

type Trie
  nodes::Vector{Node}
  count::Int
  #values::Vector{T}
  base0::Int
end

Base.length(trie::Trie) = length(trie.count)

function Base.get(trie::Trie, key::Vector{Int}, default)
  id = 1
  for k in key
    id = get(da, k, id, 0)
    id == 0 && return default
  end
  -da[id].base - 1
end

function Base.get(trie::Trie, id::Int, key::Int, default)
  nextid = da[id].base + key
  (nextid <= 0 || nextid > length(da)) && return default
  this[nextid].check == id ? nextid : default
end

function Base.resize!(trie::Trie, len::Int)
  n = length(trie.nodes)
  resize!(trie.nodes, len)
  for i = n+1:len
    trie.nodes[i] = Node(0, 0)
  end
  trie
end

function Trie(data::Vector{Vector{Int}})
  trie = Trie([Node(0,1)], 0, 1)
  resize!(trie, length(data)*2)
  items = [(1,0,length(data),1)]

  while length(items) > 0
    id, offset, len, k = pop!(items)
    keys = Int[1+offset]
    for i = 2:len
      v = data[i+offset][k]
      v != data[i+offset-1][k] && push!(keys, v)
    end
    base = findbase(trie, id, keys)
    for k in keys
      if k == 0 # leaf
        trie.count += 1
        #da.values[da.count] = value
      else
        trie.nodes[base+k] = Node(0, id)
      end
    end

    for i = len:-1:1
      key = data[i+offset][k]
      nextid =　base + key
      #(nextid, )
      v = data[i+offset][k]
    end
  end
  trie
end

function findbase(trie::Trie, id::Int, keys::Vector{Int})
  nonempty = 0
  base = trie.base0
  nodes = trie.nodes
  while true
    while base + keys[end] > length(nodes)
      resize!(trie, length(nodes)*2)
    end
    all(k -> k == 0 || !isused(nodes[base+k]), keys) && break
    isused(nodes[base+keys[1]]) && (nonempty += 1)
    base += 1
  end
  nodes[id] = Node(base, nodes[id].check)
  alpha = nonempty / (base - trie.base0 + 1)
  alpha > 0.9 && (trie.base0 = base)
  base
end

end
