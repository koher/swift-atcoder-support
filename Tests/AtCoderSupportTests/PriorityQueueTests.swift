import XCTest
@testable import AtCoderSupport

final class PriorityQueueTests: XCTestCase {
    func testAppend() {
        do {
            var queue: PriorityQueue<Int> = .init([3, 7, 2, 8, 5, 2])
            
            XCTAssertEqual(queue.first, 2)
            XCTAssertEqual(queue.count, 6)
            
            queue.append(1)
            
            XCTAssertEqual(queue.first, 1)
            XCTAssertEqual(queue.count, 7)
            
            queue.append(4)
            
            XCTAssertEqual(queue.first, 1)
            XCTAssertEqual(queue.count, 8)

            queue.append(1)
            
            XCTAssertEqual(queue.first, 1)
            XCTAssertEqual(queue.count, 9)

            queue.append(0)
            
            XCTAssertEqual(queue.first, 0)
            XCTAssertEqual(queue.count, 10)
        }
        do {
            var queue: PriorityQueue<Int> = .init()
           
            XCTAssertEqual(queue.isEmpty, true)
            
            let elements = Array(1 ... 100).shuffled()
            for (i, element) in elements.enumerated() {
                XCTAssertEqual(queue.count, i)
                XCTAssertEqual(queue.first, elements[0 ..< i].min())
                
                queue.append(element)
                
                XCTAssertEqual(queue.isEmpty, false)
            }
            
            XCTAssertEqual(queue.count, elements.count)
        }
    }
    
    func testPopFirst() {
        do {
            var queue: PriorityQueue<Int> = .init([5, 9, 2, 0, 3, 6, 2, 5])
            
            XCTAssertEqual(queue.popFirst(), 0)
            XCTAssertEqual(queue.popFirst(), 2)
            XCTAssertEqual(queue.popFirst(), 2)
            XCTAssertEqual(queue.popFirst(), 3)
            XCTAssertEqual(queue.popFirst(), 5)
            XCTAssertEqual(queue.popFirst(), 5)
            XCTAssertEqual(queue.popFirst(), 6)
            XCTAssertEqual(queue.popFirst(), 9)
            XCTAssertEqual(queue.popFirst(), nil)
        }
        do {
            var queue: PriorityQueue<Int> = .init()
            XCTAssertEqual(queue.popFirst(), nil)
        }
        do {
            var queue: PriorityQueue<(Double, Int)> = .init([
                (3.0, 4),
                (2.0, 7),
                (9.0, 8),
                (3.0, 2),
                (2.5, 6),
                (2.0, 7),
                (1.0, 9),
                (1.5, 6),
                (2.0, 5),
                (2.0, 8),
                (3.0, 2),
                (7.0, 1),
                (3.0, 3),
            ], by: <)
            
            XCTAssertEqual(queue.popFirst(), (1.0, 9))
            XCTAssertEqual(queue.popFirst(), (1.5, 6))
            XCTAssertEqual(queue.popFirst(), (2.0, 5))
            XCTAssertEqual(queue.popFirst(), (2.0, 7))
            XCTAssertEqual(queue.popFirst(), (2.0, 7))
            XCTAssertEqual(queue.popFirst(), (2.0, 8))
            XCTAssertEqual(queue.popFirst(), (2.5, 6))
            XCTAssertEqual(queue.popFirst(), (3.0, 2))
            XCTAssertEqual(queue.popFirst(), (3.0, 2))
            XCTAssertEqual(queue.popFirst(), (3.0, 3))
            XCTAssertEqual(queue.popFirst(), (3.0, 4))
            XCTAssertEqual(queue.popFirst(), (7.0, 1))
            XCTAssertEqual(queue.popFirst(), (9.0, 8))
            XCTAssertNil(queue.popFirst())
        }
        do {
            var elements = Array(1 ... 100).shuffled()
            var queue: PriorityQueue<Int> = .init(elements)
            elements.sort()
            
            for (i, element) in elements.enumerated() {
                XCTAssertEqual(queue.count, elements.count - i)
                XCTAssertEqual(queue.isEmpty, false)
                XCTAssertEqual(queue.first, element)
                XCTAssertEqual(queue.popFirst(), element)
            }
            
            XCTAssertEqual(queue.count, 0)
            XCTAssertEqual(queue.isEmpty, true)
            XCTAssertEqual(queue.first, nil)
            XCTAssertEqual(queue.popFirst(), nil)
        }
    }
    
    #if !DEBUG
    func testAppendPerformance() {
        let elements = (1 ... 100_000).shuffled()
        measure {
            var queue: PriorityQueue<Int> = .init()
            for element in elements {
                queue.append(element)
            }
            XCTAssertEqual(queue.count, elements.count)
        }
    }
    
    func testPopFirstPerformance() {
        let elements = (1 ... 100_000).shuffled()
        let queue: PriorityQueue<Int> = .init(elements)
        measure {
            var queue = queue
            while !queue.isEmpty {
                _ = queue.popFirst()
            }
            XCTAssertTrue(queue.isEmpty)
        }

    }
    #endif
}

// FIXME: SE-0283 が導入されたら取り除く
private func XCTAssertEqual<T: Equatable, U: Equatable>(_ expression1: (T, U)?, _ expression2: (T, U)?) {
    switch (expression1, expression2) {
    case (.some(let expression1), .some(let expression2)):
        XCTAssertEqual(expression1.0, expression2.0)
        XCTAssertEqual(expression1.1, expression2.1)
    case (.some(_), .none), (.none, .some(_)):
        XCTFail()
    case (.none, .none):
        break
    }
}
