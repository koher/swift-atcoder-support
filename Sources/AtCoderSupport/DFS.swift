func dfs(graph: [[Int]], startedAt start: Int, _ body: (Int) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: [Int] = [start]
    while let current = destinations.popLast() {
        if isVisited[current] { continue }
        body(current)
        isVisited[current] = true
        for destination in graph[current].reversed() {
            destinations.append(destination)
        }
    }
}

func dfs(graph: [[Int]], startedAt start: Int, _ body: (_ current: Int, _ prev: Int?) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: [(current: Int, prev: Int?)] = [(start, nil)]
    while let (current, prev) = destinations.popLast() {
        if isVisited[current] { continue }
        body(current, prev)
        isVisited[current] = true
        for destination in graph[current].reversed() {
            destinations.append((destination, current))
        }
    }
}

func dfs(graph: [[Int]], startedAt start: Int, _ body: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: [(current: Int, prev: Int?, depth: Int)] = [(start, nil, 0)]
    while let (current, prev, depth) = destinations.popLast() {
        if isVisited[current] { continue }
        body(current, prev, depth)
        isVisited[current] = true
        for destination in graph[current].reversed() {
            destinations.append((destination, current, depth + 1))
        }
    }
}

// LinkedList のコピーも必要
func dfs(graph: [[Int]], startedAt start: Int, _ body: (_ path: LinkedList<Int>) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var paths: [LinkedList<Int>] = [[start]]
    while let path = paths.popLast() {
        let current = path.first!
        if isVisited[current] { continue }
        body(path)
        isVisited[current] = true
        for destination in graph[current].reversed() {
            var nextPath = path
            nextPath.appendFirst(destination)
            paths.append(nextPath)
        }
    }
}
