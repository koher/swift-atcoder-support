import XCTest
@testable import AtCoderSupport

final class PowTests: XCTestCase {
    func testPow() {
        XCTAssertEqual(pow(2, 0, modulus: nil), 1)
        XCTAssertEqual(pow(2, 1, modulus: nil), 2)
        XCTAssertEqual(pow(2, 2, modulus: nil), 4)
        XCTAssertEqual(pow(2, 3, modulus: nil), 8)
        XCTAssertEqual(pow(2, 4, modulus: nil), 16)
        XCTAssertEqual(pow(2, 5, modulus: nil), 32)
        XCTAssertEqual(pow(2, 6, modulus: nil), 64)
        XCTAssertEqual(pow(2, 7, modulus: nil), 128)
        XCTAssertEqual(pow(2, 8, modulus: nil), 256)
        XCTAssertEqual(pow(2, 9, modulus: nil), 512)
        XCTAssertEqual(pow(2, 10, modulus: nil), 1024)

        XCTAssertEqual(pow(2, 16, modulus: nil), 65536)
        XCTAssertEqual(pow(2, 32, modulus: nil), 1 << 32)
        XCTAssertEqual(pow(2, 62, modulus: nil), 1 << 62)
        XCTAssertEqual(pow(2 as UInt, 63, modulus: nil), 1 << 63)
        
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
        XCTAssertEqual((6 * pow(3, 998244353 - 2, modulus: 998244353)) % 998244353, 2) // 6 / 3 = 2
    }
}
