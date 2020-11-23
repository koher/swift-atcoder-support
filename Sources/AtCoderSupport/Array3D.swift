struct Array3D<Element>: Sequence, CustomStringConvertible {
    let width: Int
    let height: Int
    let depth: Int
    private(set) var elements: [Element]
    let outside: Element?
    init(width: Int, height: Int, depth: Int, elements: [Element], outside: Element? = nil) {
        precondition(elements.count == width * height * depth)
        self.width = width
        self.height = height
        self.depth = depth
        self.elements = elements
        self.outside = outside
    }
    init(width: Int, height: Int, depth: Int, element: Element, outside: Element? = nil) {
        self.init(width: width, height: height, depth: depth, elements: [Element](repeating: element, count: width * height * depth), outside: outside)
    }
    var count: Int { elements.count }
    var xRange: Range<Int> { 0 ..< width }
    var yRange: Range<Int> { 0 ..< height }
    var zRange: Range<Int> { 0 ..< depth }
    private func indexAt(x: Int, y: Int, z: Int) -> Int? {
        guard xRange.contains(x) else { return nil }
        guard yRange.contains(y) else { return nil }
        guard zRange.contains(z) else { return nil }
        return (z * height + y) * width + x
    }
    subscript(x: Int, y: Int, z: Int) -> Element {
        get {
            guard let i = indexAt(x: x, y: y, z: z) else { return outside! }
            return elements[i]
        }
        set {
            guard let i = indexAt(x: x, y: y, z: z) else {
                precondition(outside != nil)
                return
            }
            elements[i] = newValue
        }
    }
    subscript(position: (Int, Int, Int)) -> Element {
        get { self[position.0, position.1, position.2] }
        set { self[position.0, position.1, position.2] = newValue }
    }
    func makeIterator() -> IndexingIterator<[Element]> {
        elements.makeIterator()
    }
    func map<T>(_ transform: (Element) throws -> T) rethrows -> Array3D<T> {
        try Array3D<T>(width: width, height: height, depth: depth, elements: elements.map(transform))
    }
    var description: String {
        var result: String = ""
        for z in zRange {
            if z > 0 {
                result.append("\n")
            }
            for y in yRange {
                for x in xRange {
                    if x > 0 {
                        result.append(" ")
                    }
                    result.append("\(self[x, y, z])")
                }
                result.append("\n")
            }
        }
        return result
    }
}
extension Array3D where Element: CustomStringConvertible {
    var description: String {
        var result: String = ""
        for z in zRange {
            if z > 0 {
                result.append("\n")
            }
            for y in yRange {
                for x in xRange {
                    if x > 0 {
                        result.append(" ")
                    }
                    result.append(self[x, y, z].description)
                }
                result.append("\n")
            }
        }
        return result
    }
}
