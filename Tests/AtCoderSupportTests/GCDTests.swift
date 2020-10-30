import XCTest
@testable import AtCoderSupport

final class GCDTests: XCTestCase {
    func testGCD() {
        XCTAssertEqual(gcd(1071, 1029), 21)
        XCTAssertEqual(gcd(1, 1), 1)
        XCTAssertEqual(gcd(12, 12), 12)
        XCTAssertEqual(gcd(12, 1), 1)
        XCTAssertEqual(gcd(5, 7), 1)
        XCTAssertEqual(gcd(13, 26), 13)
        XCTAssertEqual(gcd(31 * 43, 31 * 47), 31)
    }
}
