func bfs(edges: [[Int]], startedAt start: Int, _ operation: (Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var destinations: ArraySlice<Int> = [start]
    destinations.reserveCapacity(edges.count)
    while let current = destinations.popFirst() {
        if isVisited[current] { continue }
        operation(current)
        isVisited[current] = true
        for destination in edges[current] {
            destinations.append(destination)
        }
    }
}

func bfs(edges: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var nexts: [(current: Int, prev: Int?)] = [(start, nil)]
    while !nexts.isEmpty {
        var destinations: [(current: Int, prev: Int?)] = []
        for (current, prev) in nexts {
            if isVisited[current] { continue }
            operation(current, prev)
            isVisited[current] = true
            for destination in edges[current] {
                destinations.append((destination, current))
            }
        }
        nexts = destinations
    }
}

func bfs(edges: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var nexts: [(current: Int, prev: Int?, depth: Int)] = [(start, nil, 0)]
    while !nexts.isEmpty {
        var destinations: [(current: Int, prev: Int?, depth: Int)] = []
        for (current, prev, depth) in nexts {
            if isVisited[current] { continue }
            operation(current, prev, depth)
            isVisited[current] = true
            for destination in edges[current] {
                destinations.append((destination, current, depth + 1))
            }
        }
        nexts = destinations
    }
}
