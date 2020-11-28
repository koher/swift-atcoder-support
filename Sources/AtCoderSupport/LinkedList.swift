enum LinkedList<Element>: Sequence, IteratorProtocol, ExpressibleByArrayLiteral {
    case none
    indirect case some(Element, LinkedList<Element>)
    init() { self = .none }
    init<C>(_ collection: C) where C: BidirectionalCollection, C.Element == Element {
        self = .init()
        appendFirst(contentsOf: collection)
    }
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
    mutating func appendFirst(_ element: Element) {
        self = .some(element, self)
    }
    mutating func popFirst() -> Element? {
        switch self {
        case .none: return nil
        case .some(let element, let next):
            self = next
            return element
        }
    }
    func makeIterator() -> LinkedList<Element> {
        self
    }
    mutating func next() -> Element? {
        popFirst()
    }
    mutating func appendFirst<C>(contentsOf elements: C) where C: BidirectionalCollection, C.Element == Element {
        for element in elements.reversed() {
            appendFirst(element)
        }
    }
    func dropFirst(_ n: Int = 1) -> LinkedList<Element> {
        var result = self
        for _ in 0 ..< n {
            _ = result.popFirst()
        }
        return result
    }
    static func +(lhs: Self, rhs: Self) -> LinkedList<Element> {
        Array(lhs) + rhs
    }
    static func +<C>(lhs: C, rhs: Self) -> LinkedList<Element> where C: BidirectionalCollection, C.Element == Element {
        var result = rhs
        result.appendFirst(contentsOf: lhs)
        return result
    }
}
extension LinkedList: Equatable where Element: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        var l = lhs
        var r = rhs
        while true {
            switch (l.next(), r.next()) {
            case (.some(let a), .some(let b)):
                guard a == b else { return false }
            case (.some(_), .none), (.none, .some(_)):
                return false
            case (.none, .none):
                return true
            }
        }
    }
}
