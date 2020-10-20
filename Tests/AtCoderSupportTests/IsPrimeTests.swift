import XCTest
@testable import AtCoderSupport

final class IsPrimeTests: XCTestCase {
    func testIsPrime() {
        let primes: Set<Int> = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        for n in 0 ... 100 {
            if primes.contains(n) {
                XCTAssertTrue(n.isPrime)
            } else {
                XCTAssertFalse(n.isPrime)
            }
        }
        XCTAssertFalse((-1).isPrime)
    }
}
