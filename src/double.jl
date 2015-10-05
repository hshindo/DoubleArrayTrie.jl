type Node
  base::Int
  check::Int
  valueid::Int
end

isused(node::Node) = node.base != 0 && node.check != 0

"""
Double Array type

base: offset for child node, i.e., child = parent.base + label
check: parent id
"""
type DoubleArray{T}
  leafcode::Int
  nextcheck::Int
  nodes::Vector{Node}
  count::Int
end

length(da::DoubleArray) = da.count

function append(da::DoubleArray, parent::Int, label::Int)
  nonempty = 0
  id = nextCheck - 1
  while true
    id += 1
    base = id - codes[1]
    for
  end
end

function create(data::Vector{Vector{Int}})
  da = DoubleArray(-1, Node[], 0)

end
