module DoubleArray

export DoubleArray

include("node.jl")

"""
    Double Array
"""
type DoubleArray{T}
  nodes::Vector{Node}
  nextcheck::Int
  count::Int
end

length(da::DoubleArray) = da.count
getindex(da::DoubleArray, key::Int) = da.nodes[key]
setindex!(da::DoubleArray, value::Node, key::Int) = da.nodes[key] = value

function DoubleArray(data::Vector{Vector{Int}})
  da = DoubleArray([Node(0,1)], 1, 0)
  resize!(da, length(data)*2)



  da
end

function Base.resize!(da::DoubleArray, length::Int)
  nodes = Array(Node, length)
  da.nodes = copy!(nodes, da.nodes)
end

function append(da::DoubleArray, parent::Int, codes::Vector{Int})
  nonempty = 0
  id = da.nextcheck - 1
  while true
    id += 1
    base = id - codes[1]
    while base + codes[end] >= da.count
      resize!(da, da.count*2)
    end
    if isused(da[id])
      nonempty += 1
      continue
    end
    base < 0 && continue

    if all(c -> !isused(da[base+c]), codes)
      da[parent] = Node(base, da[parent].check)
      for c in codes
        if c == leafcode
          da.count += 1
          o = -da.count
        else
          o = 1
        end
        da[base+c] = Node(o, parent)
      end
      break
    end
  end
  alpha = nonEmpty / (id - da.nextcheck + 1)
  alpha > 0.9 && nextcheck = id
end

end
