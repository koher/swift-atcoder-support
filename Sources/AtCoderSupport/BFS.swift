func bfs(edges: [[Int]], startedAt start: Int, _ operation: (Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var visited: Set<Int> = []
    var nexts: [Int] = [start]
    while !nexts.isEmpty {
        var destinations: [Int] = []
        for current in nexts {
            if visited.contains(current) { continue }
            operation(current)
            visited.insert(current)
            for destination in edges[current] {
                destinations.append(destination)
            }
        }
        nexts = destinations
    }
}

func bfs(edges: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var visited: Set<Int> = []
    var nexts: [(current: Int, prev: Int?)] = [(start, nil)]
    while !nexts.isEmpty {
        var destinations: [(current: Int, prev: Int?)] = []
        for (current, prev) in nexts {
            if visited.contains(current) { continue }
            operation(current, prev)
            visited.insert(current)
            for destination in edges[current] {
                destinations.append((destination, current))
            }
        }
        nexts = destinations
    }
}

func bfs(edges: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var visited: Set<Int> = []
    var nexts: [(current: Int, prev: Int?, depth: Int)] = [(start, nil, 0)]
    while !nexts.isEmpty {
        var destinations: [(current: Int, prev: Int?, depth: Int)] = []
        for (current, prev, depth) in nexts {
            if visited.contains(current) { continue }
            operation(current, prev, depth)
            visited.insert(current)
            for destination in edges[current] {
                destinations.append((destination, current, depth + 1))
            }
        }
        nexts = destinations
    }
}
