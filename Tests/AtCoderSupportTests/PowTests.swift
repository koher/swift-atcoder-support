import XCTest
@testable import AtCoderSupport

final class PowTests: XCTestCase {
    func testPow() {
        XCTAssertEqual(pow(2, 0), 1)
        XCTAssertEqual(pow(2, 1), 2)
        XCTAssertEqual(pow(2, 2), 4)
        XCTAssertEqual(pow(2, 3), 8)
        XCTAssertEqual(pow(2, 4), 16)
        XCTAssertEqual(pow(2, 5), 32)
        XCTAssertEqual(pow(2, 6), 64)
        XCTAssertEqual(pow(2, 7), 128)
        XCTAssertEqual(pow(2, 8), 256)
        XCTAssertEqual(pow(2, 9), 512)
        XCTAssertEqual(pow(2, 10), 1024)

        XCTAssertEqual(pow(2, 16), 65536)
        XCTAssertEqual(pow(2, 32), 1 << 32)
        XCTAssertEqual(pow(2, 62), 1 << 62)
        XCTAssertEqual(pow(2 as UInt, 63), 1 << 63)
        
        XCTAssertEqual(pow(2, 0, modulus: 7), 1)
        XCTAssertEqual(pow(2, 1, modulus: 7), 2)
        XCTAssertEqual(pow(2, 2, modulus: 7), 4)
        XCTAssertEqual(pow(2, 3, modulus: 7), 1)
        XCTAssertEqual(pow(2, 4, modulus: 7), 2)
        XCTAssertEqual(pow(2, 5, modulus: 7), 4)
        XCTAssertEqual(pow(2, 6, modulus: 7), 1)
        XCTAssertEqual(pow(2, 7, modulus: 7), 2)
        XCTAssertEqual(pow(2, 8, modulus: 7), 4)
        XCTAssertEqual(pow(2, 9, modulus: 7), 1)
        XCTAssertEqual(pow(2, 10, modulus: 7), 2)
        
        XCTAssertEqual(pow(123456789, 2, modulus: 998244353), (123456789 * 123456789) % 998244353)
    }
}
