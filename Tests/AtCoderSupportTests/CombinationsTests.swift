import XCTest
@testable import AtCoderSupport

final class CombinationsTests: XCTestCase {
    func testNcr() {
        XCTAssertEqual(ncr(7, 0), 1)
        XCTAssertEqual(ncr(7, 1), 7)
        XCTAssertEqual(ncr(7, 2), 21)
        XCTAssertEqual(ncr(7, 3), 35)
        XCTAssertEqual(ncr(7, 4), 35)
        XCTAssertEqual(ncr(7, 5), 21)
        XCTAssertEqual(ncr(7, 6), 7)
        XCTAssertEqual(ncr(7, 7), 1)

        XCTAssertEqual(ncr(0, 0), 1)

        XCTAssertEqual(ncr(7, 0, modulus: 11), 1)
        XCTAssertEqual(ncr(7, 1, modulus: 11), 7)
        XCTAssertEqual(ncr(7, 2, modulus: 11), 10)
        XCTAssertEqual(ncr(7, 3, modulus: 11), 2)
        XCTAssertEqual(ncr(7, 4, modulus: 11), 2)
        XCTAssertEqual(ncr(7, 5, modulus: 11), 10)
        XCTAssertEqual(ncr(7, 6, modulus: 11), 7)
        XCTAssertEqual(ncr(7, 7, modulus: 11), 1)
        
        XCTAssertEqual(ncr(7 as UInt, 4), 35)
    }
}
