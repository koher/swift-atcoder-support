func dfs(edges: [[Int]], startedAt start: Int, _ body: (Int) -> Void) {
    precondition(edges.indices.contains(start))
    var visited: Set<Int> = []
    var destinations: [Int] = [start]
    while let current = destinations.popLast() {
        if visited.contains(current) { continue }
        body(current)
        visited.insert(current)
        for destination in edges[current].reversed() {
            destinations.append(destination)
        }
    }
}

func dfs(edges: [[Int]], startedAt start: Int, _ body: (_ current: Int, _ prev: Int?) -> Void) {
    precondition(edges.indices.contains(start))
    var visited: Set<Int> = []
    var destinations: [(current: Int, prev: Int?)] = [(start, nil)]
    while let (current, prev) = destinations.popLast() {
        if visited.contains(current) { continue }
        body(current, prev)
        visited.insert(current)
        for destination in edges[current].reversed() {
            destinations.append((destination, current))
        }
    }
}

func dfs(edges: [[Int]], startedAt start: Int, _ body: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(edges.indices.contains(start))
    var visited: Set<Int> = []
    var destinations: [(current: Int, prev: Int?, depth: Int)] = [(start, nil, 0)]
    while let (current, prev, depth) = destinations.popLast() {
        if visited.contains(current) { continue }
        body(current, prev, depth)
        visited.insert(current)
        for destination in edges[current].reversed() {
            destinations.append((destination, current, depth + 1))
        }
    }
}
