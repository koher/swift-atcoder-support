import XCTest
@testable import AtCoderSupport

final class SafeRangeTests: XCTestCase {
    func testRange() {
        do {
            let a: Range<Int>? = 2 ..<? 5
            XCTAssertEqual(a, 2 ..< 5)
        }
        do {
            let a: Range<Int>? = 2 ..<? 2
            XCTAssertEqual(a, 2 ..< 2)
        }
        do {
            let a: Range<Int>? = 2 ..<? 1
            XCTAssertNil(a)
        }
    }
    
    func testClosedRange() {
        do {
            let a: ClosedRange<Int>? = 2 ...? 5
            XCTAssertEqual(a, 2 ... 5)
        }
        do {
            let a: ClosedRange<Int>? = 2 ...? 2
            XCTAssertEqual(a, 2 ... 2)
        }
        do {
            let a: ClosedRange<Int>? = 2 ...? 1
            XCTAssertNil(a)
        }
    }
}
