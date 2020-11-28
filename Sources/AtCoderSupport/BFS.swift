// Deque, LinkedList のコピーも必要
func bfs(graph: [[Int]], startedAt start: Int, _ operation: (_ path: LinkedList<Int>) -> Void) {
    precondition(graph.indices.contains(start), "`start` index is out of bounds: \(start)")
    var isVisited: [Bool] = .init(repeating: false, count: graph.count)
    var destinations: Deque<LinkedList<Int>> = [[start]]
    while let path = destinations.popFirst() {
        let current = path.first!
        if isVisited[current] { continue }
        operation(path)
        isVisited[current] = true
        for destination in graph[current] {
            var newPath = path
            newPath.appendFirst(destination)
            destinations.append(newPath)
        }
    }
}
