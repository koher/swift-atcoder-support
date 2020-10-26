func bfs(edges: [[Int]], startedAt start: Int, _ operation: (Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var destinations: [Int] = [start]
    destinations.reserveCapacity(edges.count)
    var i = 0
    while i < destinations.count {
        defer { i += 1 }
        let current = destinations[i]
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
    var destinations: [(current: Int, prev: Int?)] = [(start, nil)]
    destinations.reserveCapacity(edges.count)
    var i = 0
    while i < destinations.count {
        defer { i += 1 }
        let (current, prev) = destinations[i]
        if isVisited[current] { continue }
        operation(current, prev)
        isVisited[current] = true
        for destination in edges[current] {
            destinations.append((destination, current))
        }
    }
}

func bfs(edges: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var destinations: [(current: Int, prev: Int?, depth: Int)] = [(start, nil, 0)]
    destinations.reserveCapacity(edges.count)
    var i = 0
    while i < destinations.count {
        defer { i += 1 }
        let (current, prev, depth) = destinations[i]
        if isVisited[current] { continue }
        operation(current, prev, depth)
        isVisited[current] = true
        for destination in edges[current] {
            destinations.append((destination, current, depth + 1))
        }
    }
}
