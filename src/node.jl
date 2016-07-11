"""
    Node

* base: offset for child node, i.e., child = parent.base + label
* check: parent id
"""
type Node
  base::Int
  check::Int
end

isused(n::Node) = n.base != 0 && n.check != 0

value(n::Node) = -(n.base + 1)
