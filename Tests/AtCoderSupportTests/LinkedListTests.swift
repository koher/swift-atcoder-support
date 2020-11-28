import XCTest
@testable import AtCoderSupport

final class LinkedListTests: XCTestCase {
    func testInit() {
        var a: LinkedList<Int> = .init()
        XCTAssertNil(a.next())
    }
    
    func testInitWithBidirectionalCollection() {
        var a: LinkedList<Int> = .init([2, 3, 5])
        XCTAssertEqual(a.next(), 2)
        XCTAssertEqual(a.next(), 3)
        XCTAssertEqual(a.next(), 5)
        XCTAssertNil(a.next())
    }
    
    func testInitWithArrayLiteral() {
        var a: LinkedList<Int> = [2, 3, 5]
        XCTAssertEqual(a.next(), 2)
        XCTAssertEqual(a.next(), 3)
        XCTAssertEqual(a.next(), 5)
        XCTAssertNil(a.next())
    }
    
    func testAppendFirst() {
        do {
            var a: LinkedList<Int> = [1, 1, 2, 3, 5, 8]
            a.appendFirst(0)
            XCTAssertEqual(a, [0, 1, 1, 2, 3, 5, 8])
        }
        do {
            var a: LinkedList<Character> = []
            a.appendFirst("A")
            XCTAssertEqual(a, ["A"])
        }
    }
    
    func testPopFirst() {
        do {
            var a: LinkedList<Int> = [0, 1, 1, 2, 3, 5, 8]
            XCTAssertEqual(a.popFirst(), 0)
            XCTAssertEqual(a, [1, 1, 2, 3, 5, 8])
        }
        do {
            var a: LinkedList<Bool> = []
            XCTAssertNil(a.popFirst())
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
        var a: LinkedList<Int> = .some(2, .some(3, .some(5, .none)))
        XCTAssertEqual(a.next(), 2)
        XCTAssertEqual(a.next(), 3)
        XCTAssertEqual(a.next(), 5)
        XCTAssertNil(a.next())
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
