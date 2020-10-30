import XCTest
@testable import AtCoderSupport

final class DivisorsTests: XCTestCase {
    func testDivisors() {
        do {
            let r = 12.divisors()
            XCTAssertEqual(r, [1, 2, 3, 4, 6, 12])
        }
        do { // 平方数
            let r = 36.divisors()
            XCTAssertEqual(r, [1, 2, 3, 4, 6, 9, 12, 18, 36])
        }
        do { // 素数
            let r = 127.divisors()
            XCTAssertEqual(r, [1, 127])
        }
        do { // 2 ^ 10
            let r = 1024.divisors()
            XCTAssertEqual(r, [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024])
        }
        do { // 2 * 3 * 5 * 7
            let r = (2 * 3 * 5 * 7).divisors()
            XCTAssertEqual(r, [1, 2, 3, 5, 2 * 3, 7, 2 * 5, 2 * 7, 3 * 5, 3 * 7, 2 * 3 * 5, 5 * 7, 2 * 3 * 7, 2 * 5 * 7, 3 * 5 * 7, 2 * 3 * 5 * 7])
        }
        do {
            let r = 1.divisors()
            XCTAssertEqual(r, [1])
        }
        do {
            let r = 2.divisors()
            XCTAssertEqual(r, [1, 2])
        }
        do {
            let r = 3.divisors()
            XCTAssertEqual(r, [1, 3])
        }
        do {
            let r = 4.divisors()
            XCTAssertEqual(r, [1 ,2, 4])
        }
    }
}
