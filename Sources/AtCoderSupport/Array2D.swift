struct Array2D<Element>: Sequence, CustomStringConvertible {
    typealias Coord = (row: Int, col: Int)
    let width: Int
    let height: Int
    private(set) var elements: [Element]
    let outside: Element?
    init(width: Int, height: Int, elements: [Element], outside: Element? = nil) {
        precondition(elements.count == width * height)
        self.width = width
        self.height = height
        self.elements = elements
        self.outside = outside
    }
    init(width: Int, height: Int, element: Element, outside: Element? = nil) {
        self.init(width: width, height: height, elements: [Element](repeating: element, count: width * height), outside: outside)
    }
    var count: Int { elements.count }
    var rowRange: Range<Int> { 0 ..< height }
    var colRange: Range<Int> { 0 ..< width }
    private func indexAt(r: Int, c: Int) -> Int? {
        guard rowRange.contains(r) else { return nil }
        guard colRange.contains(c) else { return nil }
        return r * width + c
    }
    subscript(r: Int, c: Int) -> Element {
        get {
            guard let i = indexAt(r: r, c: c) else {
                guard let os = outside else {
                    fatalError("(r, c)=(\(r),\(c)) is outside and the outside value of Array2D is not defined.")
                }
                return os
            }
            return elements[i]
        }
        set {
            guard let i = indexAt(r: r, c: c) else {
                precondition(outside != nil)
                return
            }
            elements[i] = newValue
        }
    }
    subscript(position: Coord) -> Element {
        get { self[position.0, position.1] }
        set { self[position.0, position.1] = newValue }
    }
    func makeIterator() -> IndexingIterator<[Element]> {
        elements.makeIterator()
    }
    func map<T>(_ transform: (Element) throws -> T) rethrows -> Array2D<T> {
        try Array2D<T>(width: width, height: height, elements: elements.map(transform))
    }
    func neighboursCoord4(around now: Coord, ignoreOutside: Bool = true) -> [Coord] {
        let dr = [0, -1, 0, 1]
        let dc = [1, 0, -1, 0]
        var res = [Coord]()
        for i in 0..<4 {
            let nr = now.row + dr[i]
            let nc = now.col + dc[i]
            if ignoreOutside {
                if indexAt(r: nr, c: nc) == nil {
                    continue
                }
            }
            res.append((nr, nc))
        }
        return res
    }
    func neighboursCoord8(around now: Coord, ignoreOutside: Bool = true) -> [Coord] {
        let dr = [0, -1, -1, -1, 0, 1, 1, 1]
        let dc = [1, 1, 0, -1, -1, -1, 0, 1]
        var res = [Coord]()
        for i in 0..<8 {
            let nr = now.row + dr[i]
            let nc = now.col + dc[i]
            if ignoreOutside {
                if indexAt(r: nr, c: nc) == nil {
                    continue
                }
            }
            res.append((nr, nc))
        }
        return res
    }
    var description: String {
        var result: String = ""
        for r in rowRange {
            for c in colRange {
                if c > 0 {
                    result.append(" ")
                }
                result.append("\(self[r, c])")
            }
            result.append("\n")
        }
        return result
    }
}
extension Array2D where Element: CustomStringConvertible {
    var description: String {
        var result: String = ""
        for r in rowRange {
            for c in colRange {
                if c > 0 {
                    result.append(" ")
                }
                result.append(self[r, c].description)
            }
            result.append("\n")
        }
        return result
    }
}
extension Array2D where Element == Character {
    init(width: Int, height: Int, stringArray: [String], outside: Element? = nil) {
        let array = stringArray.map { s in Array(s) }.flatMap { $0 }
        self.init(width: width, height: height, elements: array, outside: outside)
    }
}