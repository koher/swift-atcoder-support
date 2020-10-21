struct PriorityQueue<Element> {
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
extension PriorityQueue where Element: Comparable {
    init<S>(_ elements: S) where S: Sequence, S.Element == Element {
        self.init(elements, by: <)
    }
    
    init() {
        self.init(by: <)
    }
    
}
func dijkstra<Distance>(graph: [[(index: Int, distance: Distance)]], startedAt start: Int) -> [Int] where Distance: Comparable, Distance: AdditiveArithmetic{
    let INF = Int.max
    var dist = Array(repeating: INF, count: graph.count)
    dist[start] = 0
    var used = Array(repeating:false,count: graph.count)
    var q = PriorityQueue<(Int, Int)>(by:<=)
    q.append((0,start))
    while !q.isEmpty{
        let label = q.popFirst()!
        let prove_cost = label.0
        let src = label.1 
        
        if(used[src]){
            continue
        }
        
        used[src] = true
        dist[src] = prove_cost
        
        for edge in graph[src]{
            let cost = edge.0
            let dest = edge.1 as! Int
            if dist[dest] > dist[src]+cost{
                dist[dest] = dist[src]+cost
                q.append((dist[dest],dest))
            }
            
        }
    }
    return dist
}