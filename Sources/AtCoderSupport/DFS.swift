func dfs(edges: [[Int]], startedAt start: Int, _ body: (Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var destinations: [Int] = [start]
    while let current = destinations.popLast() {
        if isVisited[current] { continue }
        body(current)
        isVisited[current] = true
        for destination in edges[current].reversed() {
            destinations.append(destination)
        }
    }
}

func dfs(edges: [[Int]], startedAt start: Int, _ body: (_ current: Int, _ prev: Int?) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var destinations: [(current: Int, prev: Int?)] = [(start, nil)]
    while let (current, prev) = destinations.popLast() {
        if isVisited[current] { continue }
        body(current, prev)
        isVisited[current] = true
        for destination in edges[current].reversed() {
            destinations.append((destination, current))
        }
    }
}

func dfs(edges: [[Int]], startedAt start: Int, _ body: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: edges.count)
    var destinations: [(current: Int, prev: Int?, depth: Int)] = [(start, nil, 0)]
    while let (current, prev, depth) = destinations.popLast() {
        if isVisited[current] { continue }
        body(current, prev, depth)
        isVisited[current] = true
        for destination in edges[current].reversed() {
            destinations.append((destination, current, depth + 1))
        }
    }
}
