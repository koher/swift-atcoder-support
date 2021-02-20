import XCTest
@testable import AtCoderSupport

final class SafeOverflowTests: XCTestCase {
    func testAddition() {
        do {
            let a: Int? = 2 +? 3
            XCTAssertEqual(a, 5)
        }
        do {
            let a: Int? = Int.max +? 1
            XCTAssertNil(a)
        }
        do {
            let a: Int? = Int.min +? -1
            XCTAssertNil(a)
        }
    }
    
    func testSubtraction() {
        do {
            let a: Int? = 2 -? 3
            XCTAssertEqual(a, -1)
        }
        do {
            let a: Int? = Int.min -? 1
            XCTAssertNil(a)
        }
        do {
            let a: Int? = Int.max -? -1
            XCTAssertNil(a)
        }
    }
    
    func testMultiplication() {
        do {
            let a: Int? = 2 *? 3
            XCTAssertEqual(a, 6)
        }
        do {
            let a: Int? = (Int.max / 2) *? 2
            XCTAssertEqual(a, (Int.max / 2) * 2)
        }
        do {
            let a: Int? = (Int.max / 2 + 1) *? 2
            XCTAssertNil(a)
        }
        do {
            let a: Int? = (Int.min / 2) *? 2
            XCTAssertEqual(a, (Int.min / 2) * 2)
        }
        do {
            let a: Int? = (Int.min / 2 - 1) *? 2
            XCTAssertNil(a)
        }
    }
}
