import XCTest
@testable import AtCoderSupport

final class CombinationsTests: XCTestCase {
    func testNcr() {
        XCTAssertEqual(ncr(7, 0, modulus: nil), 1)
        XCTAssertEqual(ncr(7, 1, modulus: nil), 7)
        XCTAssertEqual(ncr(7, 2, modulus: nil), 21)
        XCTAssertEqual(ncr(7, 3, modulus: nil), 35)
        XCTAssertEqual(ncr(7, 4, modulus: nil), 35)
        XCTAssertEqual(ncr(7, 5, modulus: nil), 21)
        XCTAssertEqual(ncr(7, 6, modulus: nil), 7)
        XCTAssertEqual(ncr(7, 7, modulus: nil), 1)

        XCTAssertEqual(ncr(0, 0, modulus: nil), 1)

        XCTAssertEqual(ncr(7, 0, modulus: 11), 1)
        XCTAssertEqual(ncr(7, 1, modulus: 11), 7)
        XCTAssertEqual(ncr(7, 2, modulus: 11), 10)
        XCTAssertEqual(ncr(7, 3, modulus: 11), 2)
        XCTAssertEqual(ncr(7, 4, modulus: 11), 2)
        XCTAssertEqual(ncr(7, 5, modulus: 11), 10)
        XCTAssertEqual(ncr(7, 6, modulus: 11), 7)
        XCTAssertEqual(ncr(7, 7, modulus: 11), 1)
        
        XCTAssertEqual(ncr(7 as UInt, 4, modulus: nil), 35)
        XCTAssertEqual(ncr(7, 4, modulus: 998244353), 35)
    }
}
