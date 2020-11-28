protocol EdgeProtocol {
    associatedtype VertexIndex
    var destination: VertexIndex { get }
}
protocol VisitedVerticesProtocol {
    associatedtype VisitedVertexIndex
    subscript(index: VisitedVertexIndex) -> Bool { get set }
}
protocol Graph {
    associatedtype Vertex
    associatedtype VertexIndex
    associatedtype Edge: EdgeProtocol where Edge.VertexIndex == VertexIndex
    associatedtype Edges: Sequence where Edges.Element == Edge
    associatedtype VisitedVertices: VisitedVerticesProtocol where VisitedVertices.VisitedVertexIndex == VertexIndex
    var count: Int { get }
    func edges(from index: VertexIndex) -> Edges
    func visitedVertices() -> VisitedVertices
}

// `[[Int]]` を `Graph` として使う場合
extension Int: EdgeProtocol {
    var destination: Int { self }
}
extension Array: VisitedVerticesProtocol where Element == Bool {
    typealias VisitedVertexIndex = Int
}
extension Array: Graph where Element == [Int] {
    typealias Vertex = [Int]
    typealias VertexIndex = Int
    typealias Edge = Int
    typealias Edges = [Int]
    func edges(from index: Int) -> [Int] {
        self[index]
    }
    func visitedVertices() -> [Bool] {
        [Bool](repeating: false, count: count)
    }
}
