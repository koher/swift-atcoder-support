protocol VisitedVerticesProtocol {
    associatedtype VisitedVertexIndex
    subscript(index: VisitedVertexIndex) -> Bool { get set }
}
protocol Graph {
    associatedtype Vertex
    associatedtype VertexIndex
    associatedtype Edge
    associatedtype VisitedVertices: VisitedVerticesProtocol where VisitedVertices.VisitedVertexIndex == VertexIndex
    var count: Int { get }
    func visitedVertices() -> VisitedVertices
    func forEachEdge(from index: VertexIndex, _ body: (Edge) throws -> Void) rethrows
    func destination(of edge: Edge) -> VertexIndex
}

// `[[Int]]` を `Graph` として使う場合
extension Array: VisitedVerticesProtocol where Element == Bool {
    typealias VisitedVertexIndex = Int
}
extension Array: Graph where Element == [Int] {
    typealias Vertex = [Int]
    typealias VertexIndex = Int
    typealias Edge = Int
    func visitedVertices() -> [Bool] {
        [Bool](repeating: false, count: count)
    }
    func forEachEdge(from index: Int, _ body: (Int) throws -> Void) rethrows {
        for destination in self[index] {
            try body(destination)
        }
    }
    func destination(of edge: Int) -> Int { edge }
}
