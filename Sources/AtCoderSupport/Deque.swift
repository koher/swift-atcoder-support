struct Deque<Element>: MutableCollection, RandomAccessCollection, ExpressibleByArrayLiteral {
    private var buffer: Buffer<Element>
    init(_ values: [Element]) {
        buffer = Buffer(from: values, capacity: Swift.max(values.count, 16))
    }
    init(_ values: ArraySlice<Element>) {
        buffer = Buffer(from: values, capacity: Swift.max(values.count, 16))
    }
    init<S>(_ sequence: S) where S: Sequence, S.Element == Element {
        self.init([Element](sequence))
    }
    init(arrayLiteral values: Element...) {
        self.init(values)
    }
    subscript(index: Int) -> Element {
        get { buffer[index] }
        set {
            copyIfNeed()
            buffer[index] = newValue
        }
    }
    var startIndex: Int { 0 }
    var endIndex: Int { buffer.count }
    mutating func append(_ element: Element) {
        copyIfNeed()
        buffer.append(element)
    }
    mutating func popLast() -> Element? {
        copyIfNeed()
        return buffer.popLast()
    }
    @discardableResult mutating func removeLast() -> Element { popLast()! }
    mutating func appendFirst(_ element: Element) {
        copyIfNeed()
        buffer.appendFirst(element)
    }
    mutating func popFirst() -> Element? {
        copyIfNeed()
        return buffer.popFirst()
    }
    @discardableResult mutating func removeFirst() -> Element { popFirst()! }
    private mutating func copyIfNeed() {
        if !isKnownUniquelyReferenced(&buffer) {
            buffer = Buffer<Element>(from: buffer, capacity: Swift.max(buffer.count, 16))
        }
    }
    private final class Buffer<Element> {
        private var buffer: UnsafeMutablePointer<Element>
        private var capacity: Int
        private var start: Int
        private(set) var count: Int
        init(from values: [Element], capacity: Int) {
            precondition(capacity >= values.count)
            self.capacity = capacity
            self.start = 0
            self.count = values.count
            self.buffer = .allocate(capacity: capacity)
            buffer.initialize(from: values, count: count)
        }
        init(from values: ArraySlice<Element>, capacity: Int) {
            precondition(capacity >= values.count)
            self.capacity = capacity
            self.start = 0
            self.count = values.count
            self.buffer = .allocate(capacity: capacity)
            values.withUnsafeBufferPointer { buffer.initialize(from: $0.baseAddress!, count: count) }
        }
        init(from values: Buffer<Element>, capacity: Int) {
            precondition(capacity >= values.count)
            self.capacity = capacity
            self.start = 0
            self.count = values.count
            self.buffer = .allocate(capacity: capacity)
            if values.start + values.count <= values.capacity {
                buffer.initialize(from: values.buffer.advanced(by: values.start), count: values.count)
            } else {
                let n = values.capacity - values.start
                buffer.initialize(from: values.buffer.advanced(by: values.start), count: n)
                buffer.advanced(by: n).initialize(from: values.buffer, count: values.count - n)
            }
        }
        deinit {
            buffer.deallocate()
        }
        subscript(index: Int) -> Element {
            get {
                precondition((0 ..< count).contains(index))
                return buffer[(start + index) % capacity]
            }
            set {
                precondition((0 ..< count).contains(index))
                buffer[(start + index) % capacity] = newValue
            }
        }
        func append(_ element: Element) {
            if count == capacity { doubleCapacity() }
            buffer.advanced(by: (start + count) % capacity).initialize(to: element)
            count += 1
        }
        func popLast() -> Element? {
            if count == 0 { return nil }
            count -= 1
            let pointer = buffer.advanced(by: (start + count) % capacity)
            let value = pointer.pointee
            pointer.deinitialize(count: 1)
            return value
        }
        func appendFirst(_ element: Element) {
            if count == capacity { doubleCapacity() }
            start = (start - 1 + capacity) % capacity
            buffer.advanced(by: start).initialize(to: element)
            count += 1
        }
        func popFirst() -> Element? {
            if count == 0 { return nil }
            let pointer = buffer.advanced(by: start)
            let value = pointer.pointee
            pointer.deinitialize(count: 1)
            start = (start + 1) % capacity
            count -= 1
            return value
        }
        private func doubleCapacity() {
            let newCapacity = capacity * 2
            let newBuffer: UnsafeMutablePointer<Element> = .allocate(capacity: newCapacity)
            if start + count <= capacity {
                newBuffer.initialize(from: buffer.advanced(by: start), count: count)
            } else {
                let n = capacity - start
                newBuffer.initialize(from: buffer.advanced(by: start), count: n)
                newBuffer.advanced(by: n).initialize(from: buffer, count: count - n)
            }
            buffer.deallocate()
            buffer = newBuffer
            capacity = newCapacity
            start = 0
        }
    }
}
extension Deque: Equatable where Element: Equatable {
    static func == (lhs: Deque<Element>, rhs: Deque<Element>) -> Bool {
        guard lhs.count == rhs.count else { return false }
        return zip(lhs, rhs).allSatisfy { $0 == $1 }
    }
}
