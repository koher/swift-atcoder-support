import XCTest
@testable import AtCoderSupport

final class LinkedListTests: XCTestCase {
    func testInit() {
        var a: LinkedList<Int> = .init()
        XCTAssertNil(a.next())
        XCTAssertEqual(a.count, 0)
    }
    
    func testInitWithBidirectionalCollection() {
        var a: LinkedList<Int> = .init([2, 3, 5])
        XCTAssertEqual(a.count, 3)
        XCTAssertEqual(a.next(), 2)
        XCTAssertEqual(a.next(), 3)
        XCTAssertEqual(a.next(), 5)
        XCTAssertNil(a.next())
    }
    
    func testInitWithArrayLiteral() {
        var a: LinkedList<Int> = [2, 3, 5]
        XCTAssertEqual(a.count, 3)
        XCTAssertEqual(a.next(), 2)
        XCTAssertEqual(a.next(), 3)
        XCTAssertEqual(a.next(), 5)
        XCTAssertNil(a.next())
    }
    
    func testCount() {
        do {
            let a: LinkedList<Int> = []
            XCTAssertEqual(a.count, 0)
        }
        do {
            let a: LinkedList<Int> = [2, 3, 5]
            XCTAssertEqual(a.count, 3)
        }
    }
    
    func testIsEmpty() {
        do {
            let a: LinkedList<Int> = []
            XCTAssertTrue(a.isEmpty)
        }
        do {
            let a: LinkedList<Character> = ["A"]
            XCTAssertFalse(a.isEmpty)
        }
    }
    
    func testFirst() {
        do {
            let a: LinkedList<Int> = []
            XCTAssertNil(a.first)
        }
        do {
            let a: LinkedList<Int> = [2, 3, 5]
            XCTAssertEqual(a.first, 2)
        }
    }
    
    func testAppendFirst() {
        do {
            var a: LinkedList<Int> = [1, 1, 2, 3, 5, 8]
            XCTAssertEqual(a.count, 6)
            a.appendFirst(0)
            XCTAssertEqual(a.count, 7)
            XCTAssertEqual(a, [0, 1, 1, 2, 3, 5, 8])
        }
        do {
            var a: LinkedList<Character> = []
            XCTAssertEqual(a.count, 0)
            a.appendFirst("A")
            XCTAssertEqual(a.count, 1)
            XCTAssertEqual(a, ["A"])
        }
    }
    
    func testPopFirst() {
        do {
            var a: LinkedList<Int> = [0, 1, 1, 2, 3, 5, 8]
            XCTAssertEqual(a.count, 7)
            XCTAssertEqual(a.popFirst(), 0)
            XCTAssertEqual(a.count, 6)
            XCTAssertEqual(a, [1, 1, 2, 3, 5, 8])
        }
        do {
            var a: LinkedList<Bool> = []
            XCTAssertEqual(a.count, 0)
            XCTAssertNil(a.popFirst())
            XCTAssertEqual(a.count, 0)
        }
    }
    
    func testMakeIterator() {
        do {
            let a: LinkedList<Int> = [2, 3, 5]
            var iterator = a.makeIterator()
            XCTAssertEqual(iterator.next(), 2)
            XCTAssertEqual(iterator.next(), 3)
            XCTAssertEqual(iterator.next(), 5)
            XCTAssertNil(iterator.next())
        }
        do {
            let a: LinkedList<Int> = [2, 3, 5]
            var r: [Int] = []
            for element in a {
                r.append(element)
            }
            XCTAssertEqual(r, [2, 3, 5])
        }
    }
    
    func testNext() {
        var a: LinkedList<Int> = [2, 3, 5]
        XCTAssertEqual(a.count, 3)
        XCTAssertFalse(a.isEmpty)

        XCTAssertEqual(a.next(), 2)
        XCTAssertEqual(a.count, 2)
        XCTAssertFalse(a.isEmpty)

        XCTAssertEqual(a.next(), 3)
        XCTAssertEqual(a.count, 1)
        XCTAssertFalse(a.isEmpty)

        XCTAssertEqual(a.next(), 5)
        XCTAssertEqual(a.count, 0)
        XCTAssertTrue(a.isEmpty)

        XCTAssertNil(a.next())
        XCTAssertEqual(a.count, 0)
        XCTAssertTrue(a.isEmpty)
    }
    
    func testAppendFirstContentsOf() {
        var a: LinkedList<Int> = .init(5 ..< 10)
        a.appendFirst(contentsOf: 0 ..< 5)
        XCTAssertEqual(a, .init(0 ..< 10))
    }

    func testDropFirst() {
        do {
            let a: LinkedList<Int> = [0, 1, 1, 2, 3, 5, 8]
            XCTAssertEqual(a.dropFirst(), [1, 1, 2, 3, 5, 8])
        }
        do {
            let a: LinkedList<Bool> = []
            XCTAssertEqual(a.dropFirst(), [])
        }
        do {
            let a: LinkedList<Int> = .init(0 ..< 10)
            XCTAssertEqual(a.dropFirst(3), .init(3 ..< 10))
        }
    }
    
    func testPlus() {
        do {
            let a: [Character] = ["A", "B", "C"]
            let b: LinkedList<Character> = ["D", "E", "F", "G"]
            XCTAssertEqual(a + b, ["A", "B", "C", "D", "E", "F", "G"])
        }
        do {
            let a: LinkedList<Character> = ["A", "B", "C"]
            let b: LinkedList<Character> = ["D", "E", "F", "G"]
            XCTAssertEqual(a + b, ["A", "B", "C", "D", "E", "F", "G"])
        }
    }
}
