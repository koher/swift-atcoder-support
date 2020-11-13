struct Array2D<Element>: Sequence {
    let width: Int
    let height: Int
    private(set) var elements: [Element]
    init(width: Int, height: Int, elements: [Element]) {
        precondition(elements.count == width * height)
        self.width = width
        self.height = height
        self.elements = elements
    }
    init(width: Int, height: Int, element: Element) {
        self.init(width: width, height: height, elements: [Element](repeating: element, count: width * height))
    }
    var count: Int { width * height }
    var xRange: Range<Int> { 0 ..< width }
    var yRange: Range<Int> { 0 ..< height }
    private func indexAt(x: Int, y: Int) -> Int {
        precondition(xRange.contains(x))
        precondition(yRange.contains(y))
        return y * width + x
    }
    subscript(x: Int, y: Int) -> Element {
        get { elements[indexAt(x: x, y: y)] }
        set { elements[indexAt(x: x, y: y)] = newValue }
    }
    func makeIterator() -> IndexingIterator<[Element]> {
        elements.makeIterator()
    }
    func map<T>(_ transform: (Element) throws -> T) rethrows -> Array2D<T> {
        try Array2D<T>(width: width, height: height, elements: elements.map(transform))
    }
}
