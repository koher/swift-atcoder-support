// Deque, LinkedList, Graph のコピーも必要
func bfs<G>(graph: G, startedAt start: G.VertexIndex, _ operation: (_ path: LinkedList<G.VertexIndex>) -> Void) where G: Graph {
    var isVisited: G.VisitedVertices = graph.visitedVertices()
    var destinations: Deque<LinkedList<G.VertexIndex>> = [[start]]
    while let path = destinations.popFirst() {
        let current = path.first!
        if isVisited[current] { continue }
        operation(path)
        isVisited[current] = true
        for edge in graph.edges(from: current) {
            var newPath = path
            newPath.appendFirst(edge.destination)
            destinations.append(newPath)
        }
    }
}
