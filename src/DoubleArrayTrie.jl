module DoubleArrayTrie

export DATrie

"""
* child = parent.base + key
* child.check == parent
"""
immutable Node
  base::Int
  check::Int
end

isused(n::Node) = n.check > 0

type DATrie{T}
  nodes::Vector{Node}
  values::Vector{T}
  count::Int
  base0::Int
end

Base.length(trie::DATrie) = trie.count

function Base.get(trie::DATrie, keys::Vector{Int}, default)
  nodeid = 1
  for k in keys
    nodeid = get(trie, nodeid, k, 0)
    #println(nodeid)
    nodeid == 0 && return default
  end
  nodeid = get(trie, nodeid, 0, 0)
  @assert nodeid != 0
  trie.values[trie.nodes[nodeid].base]
end

function Base.get(trie::DATrie, nodeid::Int, key::Int, default)
  nextid = trie.nodes[nodeid].base + key
  (nextid <= 0 || nextid > length(trie.nodes)) && return default
  trie.nodes[nextid].check == nodeid ? nextid : default
end

function Base.resize!(trie::DATrie, len::Int)
  n = length(trie.nodes)
  resize!(trie.nodes, len)
  for i = n+1:len
    trie.nodes[i] = Node(0, 0)
  end
  trie
end

"""
    DATrie{T}(keys, values)

Construct DATrie.
"""
function DATrie{T}(keys::Vector{Vector{Int}}, values::Vector{T})
  @assert length(keys) == length(values)
  # initialize
  trie = DATrie([Node(0,1)], values, length(keys), 1)
  resize!(trie, length(keys)*2)
  keys = map(keys) do key
    any(k -> k <= 0, key) && throw("Key must be positive.")
    push!(copy(key), 0) # append '0' to the end
  end

  items = [(1,1:length(trie),1)]
  while length(items) > 0
    nodeid, range, depth = pop!(items)

    subranges = Range[]
    k = first(range)
    for i in range
      keys[i][depth] == keys[k][depth] && continue
      push!(subranges, k:i-1)
      k = i
    end
    push!(subranges, k:last(range))

    child_keys = map(r -> keys[first(r)][depth], subranges)
    base = append!(trie, nodeid, first(range), child_keys)

    for i = length(subranges):-1:1
      r = subranges[i]
      key = keys[first(r)][depth]
      key == 0 && continue # leaf
      push!(items, (base+key, r, depth+1))
    end
  end
  trie
end

function append!(trie::DATrie, nodeid::Int, keyid::Int, keys::Vector{Int})
  nonempty = 0
  base = trie.base0
  nodes = trie.nodes
  while true
    while base + keys[end] > length(nodes)
      resize!(trie, length(nodes)*2)
    end
    all(k -> !isused(nodes[base+k]), keys) && break
    isused(nodes[base+keys[1]]) && (nonempty += 1)
    base += 1
  end
  nodes[nodeid] = Node(base, nodes[nodeid].check)
  for k in keys
    nodes[base+k] = Node(keyid, nodeid)
  end
  alpha = nonempty / (base - trie.base0 + 1)
  alpha > 0.9 && (trie.base0 = base)
  base
end

end
