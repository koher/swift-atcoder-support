func bfs<Node>(nodes: [Node], edges: [[Int]], startedAt start: Int, _ operation: (Node) -> Void) {
    precondition(nodes.count == edges.count)
    precondition(nodes.indices.contains(start))
    var visited: Set<Int> = []
    var nexts: [Int] = [start]
    while !nexts.isEmpty {
        var destinations: [Int] = []
        for current in nexts {
            if visited.contains(current) { continue }
            operation(nodes[current])
            visited.insert(current)
            for destination in edges[current] {
                destinations.append(destination)
            }
        }
        nexts = destinations
    }
}

func bfs<Node>(nodes: inout [Node], edges: [[Int]], startedAt start: Int, _ operation: (inout Node) -> Void) {
    precondition(nodes.count == edges.count)
    precondition(nodes.indices.contains(start))
    var visited: Set<Int> = []
    var nexts: [Int] = [start]
    while !nexts.isEmpty {
        var destinations: [Int] = []
        for current in nexts {
            if visited.contains(current) { continue }
            operation(&nodes[current])
            visited.insert(current)
            for destination in edges[current] {
                destinations.append(destination)
            }
        }
        nexts = destinations
    }
}
