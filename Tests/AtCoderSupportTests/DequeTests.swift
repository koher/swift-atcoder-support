import XCTest
@testable import AtCoderSupport

final class DequeTests: XCTestCase {
    func testInitFromSequence() {
        let deque: Deque<Int> = .init(1 ... 3)
        XCTAssertEqual(deque.count, 3)
        XCTAssertEqual(deque.first, 1)
        XCTAssertEqual(deque.last, 3)
    }
    
    func testAppend() {
        var deque: Deque<Int> = []
        for n in 1 ... 100 {
            deque.append(n)
            XCTAssertEqual(deque.count, n)
            XCTAssertEqual(deque[0], 1)
            XCTAssertEqual(deque[n - 1], n)
            XCTAssertEqual(Array(deque), Array(1 ... n))
        }
    }
    
    func testPopLast() {
        var deque: Deque<Int> = .init(1 ... 100)
        var n = 100
        while let last = deque.popLast() {
            XCTAssertEqual(last, n)
            n -= 1
            if deque.isEmpty { continue }
            XCTAssertEqual(deque.count, n)
            XCTAssertEqual(deque[0], 1)
            XCTAssertEqual(deque[n - 1], n)
            XCTAssertEqual(Array(deque), Array(1 ... n))
        }
    }

    func testPrepend() {
        var deque: Deque<Int> = []
        for n in 1 ... 100 {
            deque.prepend(n)
            XCTAssertEqual(deque.count, n)
            XCTAssertEqual(deque[0], n)
            XCTAssertEqual(deque[n - 1], 1)
            XCTAssertEqual(Array(deque), Array((1 ... n).reversed()))
        }
    }
    
    func testPopFirst() {
        var deque: Deque<Int> = .init((1 ... 100).reversed())
        var n = 100
        while let first = deque.popFirst() {
            XCTAssertEqual(first, n)
            n -= 1
            if deque.isEmpty { continue }
            XCTAssertEqual(deque.count, n)
            XCTAssertEqual(deque[0], n)
            XCTAssertEqual(deque[n - 1], 1)
            XCTAssertEqual(Array(deque), Array((1 ... n).reversed()))
        }
    }
    
    func testEqOperator() {
        do {
            let deque: Deque<Int> = [2, 3, 5]
            XCTAssertEqual(deque, [2, 3, 5])
        }
        do {
            let deque: Deque<Int> = []
            XCTAssertEqual(deque, [])
        }
    }
    
    #if !DEBUG
    func testAppendPerformance() {
        measure {
            var deque: Deque<Int> = []
            for n in 1 ... 1_000_000 {
                if n.isMultiple(of: 2) {
                    deque.append(n)
                } else {
                    deque.prepend(n)
                }
            }
            XCTAssertEqual(deque.count, 1_000_000)
        }
    }
    #endif
}
