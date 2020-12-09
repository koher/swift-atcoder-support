import XCTest
@testable import AtCoderSupport

final class BigIntTests: XCTestCase {
    func testInitWithString() {
        do {
            let a: BigInt? = BigInt("1267650600228229401496703205376")
            XCTAssertEqual(a, .pow(2, 100))
        }
        do {
            let a: BigInt? = BigInt("-1267650600228229401496703205376")
            XCTAssertEqual(a, -.pow(2, 100))
        }
        do {
            let a: BigInt? = BigInt("0")
            XCTAssertEqual(a, 0)
        }
        do {
            let a: BigInt? = BigInt("ABC")
            XCTAssertNil(a)
        }
    }
    
    func testDescription() {
        do {
            let a: BigInt = 42
            XCTAssertEqual(a.description, "42")
        }
        do {
            let a: BigInt = -1
            XCTAssertEqual(a.description, "-1")
        }
        do {
            let a: BigInt = .init(Int.max) + 1
            XCTAssertEqual(a.description, "9223372036854775808")
        }
    }
    
    func testPlus() {
        do {
            let a: BigInt = 2
            let b: BigInt = 3
            XCTAssertEqual(a + b, 5)
        }
    }
    
    func testMinus() {
        do {
            let a: BigInt = 2
            let b: BigInt = 3
            XCTAssertEqual(a - b, -1)
        }
    }
    
    func testTimes() {
        do {
            let a: BigInt = 2
            let b: BigInt = 3
            XCTAssertEqual(a * b, 6)
        }
    }
    
    func testDivide() {
        do {
            let a: BigInt = 7
            let b: BigInt = 3
            XCTAssertEqual(a / b, 2)
        }
        do {
            let a: BigInt = -7
            let b: BigInt = 3
            XCTAssertEqual(a / b, -2)
        }
    }
    
    func testReminder() {
        do {
            let a: BigInt = 6
            let b: BigInt = 3
            XCTAssertEqual(a % b, 0)
        }
        do {
            let a: BigInt = 7
            let b: BigInt = 3
            XCTAssertEqual(a % b, 1)
        }
        do {
            let a: BigInt = 8
            let b: BigInt = 3
            XCTAssertEqual(a % b, 2)
        }
        do {
            let a: BigInt = -6
            let b: BigInt = 3
            XCTAssertEqual(a % b, 0)
        }
        do {
            let a: BigInt = -7
            let b: BigInt = 3
            XCTAssertEqual(a % b, -1)
        }
        do {
            let a: BigInt = -8
            let b: BigInt = 3
            XCTAssertEqual(a % b, -2)
        }
    }
    
    func testPow() {
        do {
            let a: BigInt = 2
            let b: Int = 100
            let r: BigInt = .pow(a, b)
            XCTAssertEqual(r, (1 ... 100).reduce(1 as BigInt) { r, _ in r * 2 })
            XCTAssertEqual(r.description, "1267650600228229401496703205376")
        }
    }
}
