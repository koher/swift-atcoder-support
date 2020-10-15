import XCTest
@testable import AtCoderSupport

final class PrimesTests: XCTestCase {
    func testPrimes() {
        do {
            let r = primes(upTo: 100)
            XCTAssertEqual(r, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97])
        }
        do {
            let r = primes(upTo: 101)
            XCTAssertEqual(r, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101])
        }
        do {
            let r = primes(upTo: 0)
            XCTAssertEqual(r, [])
        }
        do {
            let r = primes(upTo: 1)
            XCTAssertEqual(r, [])
        }
        do {
            let r = primes(upTo: 2)
            XCTAssertEqual(r, [2])
        }
        do {
            let r = primes(upTo: 3)
            XCTAssertEqual(r, [2, 3])
        }
        do {
            let r = primes(upTo: 4)
            XCTAssertEqual(r, [2, 3])
        }
        do {
            let r = primes(upTo: 5)
            XCTAssertEqual(r, [2, 3, 5])
        }
    }
    
    func testPrimesPerformance() {
        measure {
            let r = primes(upTo: 10_000_000)
            XCTAssertEqual(r.count, 664_579)
        }
    }
}
