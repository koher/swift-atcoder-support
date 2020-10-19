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
    
    init<S>(_ elements: S) where S: Sequence, S.Element == Element, Element: Comparable {
        self.init(elements, by: <)
    }
    
    init() where Element: Comparable {
        self.init(by: <)
    }
    
    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    var first: Element? { elements.first }
    
    mutating func append(_ element: Element) {
        var i = elements.count
        elements.append(element)
        while i > 0 {
            let parentIndex = (i - 1) >> 1
            let parent = elements[parentIndex]
            guard areInIncreasingOrder(element, parent) else { break }
            elements[parentIndex] = element
            elements[i] = parent
            i = parentIndex
        }
    }
    
    mutating func popFirst() -> Element? {
        guard let element = elements.popLast() else { return nil }
        guard let first = elements.first else { return element }
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

        return first
    }
}
