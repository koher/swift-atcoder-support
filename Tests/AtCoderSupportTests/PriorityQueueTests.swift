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
