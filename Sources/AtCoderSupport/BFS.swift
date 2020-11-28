// Deque のコピーも必要
func bfs(graph: [[Int]], startedAt start: Int, _ operation: (Int) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: Deque<Int> = [start]
    while let current = destinations.popFirst() {
        if isVisited[current] { continue }
        operation(current)
        isVisited[current] = true
        for destination in graph[current] {
            destinations.append(destination)
        }
    }
}

// Deque のコピーも必要
func bfs(graph: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: Deque<(current: Int, prev: Int?)> = [(start, nil)]
    while let (current, prev) = destinations.popFirst() {
        if isVisited[current] { continue }
        operation(current, prev)
        isVisited[current] = true
        for destination in graph[current] {
            destinations.append((destination, current))
        }
    }
}

// Deque のコピーも必要
func bfs(graph: [[Int]], startedAt start: Int, _ operation: (_ current: Int, _ prev: Int?, _ depth: Int) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: Deque<(current: Int, prev: Int?, depth: Int)> = [(start, nil, 0)]
    while let (current, prev, depth) = destinations.popFirst() {
        if isVisited[current] { continue }
        operation(current, prev, depth)
        isVisited[current] = true
        for destination in graph[current] {
            destinations.append((destination, current, depth + 1))
        }
    }
}

// Deque, LinkedList のコピーも必要
func bfs(graph: [[Int]], startedAt start: Int, _ operation: (_ path: LinkedList<Int>) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var paths: Deque<LinkedList<Int>> = [[start]]
    while let path = paths.popFirst() {
        let current = path.first!
        if isVisited[current] { continue }
        operation(path)
        isVisited[current] = true
        for destination in graph[current] {
            var newPath = path
            newPath.appendFirst(destination)
            paths.append(newPath)
        }
    }
}
