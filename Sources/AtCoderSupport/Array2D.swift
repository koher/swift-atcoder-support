struct Array2D<Element>: Sequence, CustomStringConvertible {
    typealias Coord = (row: Int, col: Int)
    let quadDirectionUnitVec = [(0, 1), (-1, 0), (0, -1), (1, 0)]
    let octaDirectionUnitVec = [(0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1), (1, 0), (1, 1)]

    let width: Int
    let height: Int
    private(set) var elements: [Element]
    let outside: Element?
    init(height: Int, width: Int, elements: [Element], outside: Element? = nil) {
        precondition(elements.count == width * height)
        self.width = width
        self.height = height
        self.elements = elements
        self.outside = outside
    }
    init(height: Int, width: Int, element: Element, outside: Element? = nil) {
        self.init(height: height, width: width, elements: [Element](repeating: element, count: width * height), outside: outside)
    }
    var count: Int { elements.count }
    var rowRange: Range<Int> { 0 ..< height }
    var colRange: Range<Int> { 0 ..< width }
    private func boardContains(coord: Coord) -> Bool { rowRange.contains(coord.row) && colRange.contains(coord.col) }
    private func boardNotContains(coord: Coord) -> Bool { !boardContains(coord: coord) }
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
        try Array2D<T>(height: height, width: width, elements: elements.map(transform))
    }
    func neighbours(around now: Coord, ignoreOutside: Bool = true) -> [Coord] {
        var res = [Coord]()
        for i in 0..<4 {
            let nr = now.row + quadDirectionUnitVec[i].0
            let nc = now.col + quadDirectionUnitVec[i].1
            if ignoreOutside && boardNotContains(coord: (row: nr, col: nc)) {
                continue
            }
            res.append((nr, nc))
        }
        return res
    }
    func surroundings(around now: Coord, ignoreOutside: Bool = true) -> [Coord] {
        var res = [Coord]()
        for i in 0..<8 {
            let nr = now.row + octaDirectionUnitVec[i].0
            let nc = now.col + octaDirectionUnitVec[i].1
            if ignoreOutside {
                if indexAt(r: nr, c: nc) == nil {
                    continue
                }
            }
            res.append((nr, nc))
        }
        return res
    }
    func locationList(condition: (Element) -> Bool) -> [Coord] {
        var res = [Coord]()
        for (i, e) in elements.enumerated() {
            guard condition(e) else { continue }
            res.append((row: i / width, i % width))
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
    init(height: Int, width: Int, stringArray: [String], outside: Element? = nil) {
        let array = stringArray.map { s in Array(s) }.flatMap { $0 }
        self.init(height: height, width: width, elements: array, outside: outside)
    }
    func seek(word: String) -> [Coord]? {
        let wcs = Array(word)
        for row in 0..<height {
            for col in 0..<width {
                for (ir, ic) in octaDirectionUnitVec {
                    var buf = ""
                    var loc = [Coord]()
                    for scale in 0..<wcs.count {
                        let destination = (row + scale * ir, col + scale * ic)
                        guard boardContains(coord: destination) else { break }
                        buf.append(self[destination])
                        loc.append(destination)
                    }
                    if buf == word {
                        return loc
                    }
                }
            }
        }
        return nil
    }
}