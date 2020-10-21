private struct _PriorityQueue<Element> {
    private var elements: [Element] = []
    private let areInIncreasingOrder: (Element, Element) -> Bool
    
    init<S>(_ elements: S, by areInIncreasingOrder: @escaping (Element, Element) -> Bool) where S: Sequence, S.Element == Element {
        self.areInIncreasingOrder = areInIncreasingOrder
        for element in elements {
            append(element)
        }
    }
    
    init(by areInIncreasingOrder: @escaping (Element, Element) -> Bool) {
        self.init(EmptyCollection(), by: areInIncreasingOrder)
    }
    
    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    var first: Element? { elements.first }
    
    mutating func append(_ element: Element) {
        var i = elements.count
        elements.append(element)
        elements.withUnsafeMutableBufferPointer { elements in
            while i > 0 {
                let parentIndex = (i - 1) >> 1
                let parent = elements[parentIndex]
                guard areInIncreasingOrder(element, parent) else { break }
                elements[parentIndex] = element
                elements[i] = parent
                i = parentIndex
            }
        }
    }
    
    mutating func popFirst() -> Element? {
        guard let element = elements.popLast() else { return nil }
        guard let first = elements.first else { return element }
        
        elements.withUnsafeMutableBufferPointer { elements in
            elements[0] = element
            
            var  i = 0
            while true {
                var childIndex: Int = (i << 1) + 1
                guard childIndex < elements.count else { break }
                var child: Element = elements[childIndex]
                let rightIndex = childIndex + 1
                if rightIndex < elements.count {
                    let right = elements[rightIndex]
                    if areInIncreasingOrder(right, child) {
                        childIndex = rightIndex
                        child = right
                    }
                }
                if areInIncreasingOrder(element, child) { break }
                elements[childIndex] = element
                elements[i] = child
                i = childIndex
            }
        }

        return first
    }
}
protocol HasInfinity {
    static var infinity: Self { get }
}
extension Int: HasInfinity { static var infinity: Int { .max } }
extension UInt: HasInfinity { static var infinity: UInt { .max } }
extension Float: HasInfinity {}
extension Double: HasInfinity {}
func dijkstra<Distance>(graph: [[(index: Int, distance: Distance)]], startedAt start: Int) -> [Distance] where Distance: Comparable, Distance: AdditiveArithmetic, Distance: HasInfinity {
    var result: [Distance] = .init(repeating: .infinity, count: graph.count)
    result[start] = .zero
    var used = Array(repeating:false, count: graph.count)
    var queue = PriorityQueue<(Int, Distance)>(by: <=)
    queue.append((start, .zero))
    while let (from, _) = queue.popFirst() {
        if used[from] { continue }
        used[from] = true
        for (to, distance) in graph[from]{
            if result[from] + distance < result[to] {
                result[to] = result[from] + distance
                queue.append((to, result[to]))
            }
        }
    }
    return result
}
