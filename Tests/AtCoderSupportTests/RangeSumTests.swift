import XCTest
@testable import AtCoderSupport

final class RangeSumTests: XCTestCase {
    func testSum() {
        XCTAssertEqual((1 ... 10).sum(), 55)
        XCTAssertEqual((-10 ... 100).sum(), 4995)
        XCTAssertEqual((-10 ... -1).sum(), -55)
        XCTAssertEqual((-100 ... 10).sum(), -4995)
        XCTAssertEqual((1 ... 10).sum(modulus: 13), 55 % 13)
        XCTAssertEqual((-10 ... 100).sum(modulus: 13), 4995 % 13)
        XCTAssertEqual((-10 ... -1).sum(modulus: 13), -55 % 13 + 13)
        XCTAssertEqual((-100 ... 10).sum(modulus: 13), -4995 % 13 + 13)
    }
}
