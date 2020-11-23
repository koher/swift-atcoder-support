struct ArrayND<Element>: Sequence {
    let lengths: [Int]
    private(set) var elements: [Element]
    let outside: Element?
    init(lengths: [Int], elements: [Element], outside: Element? = nil) {
        precondition(lengths.allSatisfy { $0 >= 0 })
        precondition(elements.count == lengths.reduce(1, *))
        self.lengths = lengths
        self.elements = elements
        self.outside = outside
    }
    init(lengths: [Int], element: Element, outside: Element? = nil) {
        self.init(lengths: lengths, elements: [Element](repeating: element, count: lengths.reduce(1, *)), outside: outside)
    }
    var count: Int { elements.count }
    private func indexAt(_ indices: [Int]) -> Int? {
        precondition(indices.count == lengths.count)
        var result = 0
        for (i, index) in indices.enumerated().reversed() {
            guard (0 ..< lengths[i]).contains(index) else { return nil }
            result += index
            if i > 0 {
                result *= lengths[i - 1]
            }
        }
        return result
    }
    subscript(indices: Int...) -> Element {
        get {
            guard let i = indexAt(indices) else { return outside! }
            return elements[i]
        }
        set {
            guard let i = indexAt(indices) else {
                precondition(outside != nil)
                return
            }
            elements[i] = newValue
        }
    }
    func makeIterator() -> IndexingIterator<[Element]> {
        elements.makeIterator()
    }
    func map<T>(_ transform: (Element) throws -> T) rethrows -> ArrayND<T> {
        try ArrayND<T>(lengths: lengths, elements: elements.map(transform))
    }
}
