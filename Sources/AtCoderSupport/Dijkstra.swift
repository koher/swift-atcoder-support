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
private enum _WithInfinity<Value>: Comparable where Value: Comparable, Value: AdditiveArithmetic {
    case normal(Value)
    case infinity
    
    static var zero: _WithInfinity<Value> { .normal(.zero) }
    static func + (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
        case (.normal(let lValue), .normal(let rValue)):
            return .normal(lValue + rValue)
        case (.infinity, .normal(_)), (.normal(_), .infinity), (.infinity, .infinity):
            return .infinity
        }
    }
}
func dijkstra<Distance>(graph: [[(index: Int, distance: Distance)]], startedAt start: Int) -> [Distance] where Distance: Comparable, Distance: AdditiveArithmetic{
    var result: [_WithInfinity<Distance>] = .init(repeating: .infinity, count: graph.count)
    result[start] = .zero
    var used = Array(repeating:false, count: graph.count)
    var queue = PriorityQueue<(Int, _WithInfinity<Distance>)>(by: <=)
    queue.append((start, .zero))
    while let (from, _) = queue.popFirst() {
        if used[from] { continue }
        used[from] = true
        for (to, distance) in graph[from]{
            if result[from] + .normal(distance) < result[to] {
                result[to] = result[from] + .normal(distance)
                queue.append((to, result[to]))
            }
        }
    }
    return result.map {
        if case .normal(let distance) = $0 {
            return distance
        } else {
            preconditionFailure()
        }
    }
}
