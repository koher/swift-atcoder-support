func dfs<Node>(nodes: [Node], edges: [[Int]], startedAt start: Int, _ operation: (Node) -> Void) {
    precondition(nodes.count == edges.count)
    precondition(nodes.indices.contains(start))
    var visited: Set<Int> = []
    var destinations: [Int] = [start]
    while let current = destinations.popLast() {
        if visited.contains(current) { continue }
        operation(nodes[current])
        visited.insert(current)
        for destination in edges[current].reversed() {
            destinations.append(destination)
        }
    }
}

func dfs<Node>(nodes: inout [Node], edges: [[Int]], startedAt start: Int, _ operation: (inout Node) -> Void) {
    precondition(nodes.count == edges.count)
    precondition(nodes.indices.contains(start))
    var visited: Set<Int> = []
    var destinations: [Int] = [start]
    while let current = destinations.popLast() {
        if visited.contains(current) { continue }
        operation(&nodes[current])
        visited.insert(current)
        for destination in edges[current].reversed() {
            destinations.append(destination)
        }
    }
}
