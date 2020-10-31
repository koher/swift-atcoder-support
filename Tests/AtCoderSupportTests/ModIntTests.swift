import XCTest
@testable import AtCoderSupport

final class ModIntTests: XCTestCase {
    func testInit() {
        do {
            let r: ModInt = 0
            XCTAssertEqual(r.value, 0)
        }
        do {
            let r: ModInt = 1
            XCTAssertEqual(r.value, 1)
        }
        do {
            let r: ModInt = .init(modulus - 1)
            XCTAssertEqual(r.value, modulus - 1)
        }
        do {
            let r: ModInt = .init(modulus)
            XCTAssertEqual(r.value, 0)
        }
        do {
            let r: ModInt = .init(modulus + 1)
            XCTAssertEqual(r.value, 1)
        }
        do {
            let r: ModInt = .init(modulus * 10 + 42)
            XCTAssertEqual(r.value, 42)
        }
        do {
            let r: ModInt = -1
            XCTAssertEqual(r.value, modulus - 1)
        }
        do {
            let r: ModInt = .init(Int(modulus) * -10 - 42)
            XCTAssertEqual(r.value, modulus - 42)
        }
    }
    
    func testPlus() {
        do {
            let n = modulus - 1
            let a: ModInt = .init(n)
            let r = a + a
            XCTAssertEqual(r.value, (n + n) % modulus)
        }
        do {
            let a: ModInt = 3
            let r = a + 1
            XCTAssertEqual(r.value, 4)
        }
        do {
            let a: ModInt = .init(modulus - 1)
            let r = a + 1
            XCTAssertEqual(r.value, 0)
        }
    }
    
    func testMinus() {
        do {
            let a: ModInt = .init(modulus - 1)
            let r = 1 - a
            XCTAssertEqual(r.value, 2)
        }
        do {
            let a: ModInt = 3
            let r = a  - 1
            XCTAssertEqual(r.value, 2)
        }
        do {
            let a: ModInt = 3
            let r = a - a
            XCTAssertEqual(r.value, 0)
        }
    }
    
    func testTimes() {
        do {
            let n = modulus - 1
            let a: ModInt = .init(n)
            let r = a * a
            XCTAssertEqual(r.value, (n * n) % modulus)
        }
        do {
            let n = modulus - 1
            let a: ModInt = .init(n)
            let r = a * 2
            XCTAssertEqual(r.value, (n + n) % modulus)
        }
    }
    
    func testPlusEqual() {
        do {
            let n = modulus - 1
            var r: ModInt = .init(n)
            r += r
            XCTAssertEqual(r.value, (n + n) % modulus)
        }
        do {
            var r: ModInt = 3
            r += 1
            XCTAssertEqual(r.value, 4)
        }
        do {
            var r: ModInt = .init(modulus - 1)
            r += 1
            XCTAssertEqual(r.value, 0)
        }
    }
    
    func testMinusEqual() {
        do {
            var r: ModInt = 1
            r -= ModInt(modulus - 1)
            XCTAssertEqual(r.value, 2)
        }
        do {
            var r: ModInt = 3
            r -= 1
            XCTAssertEqual(r.value, 2)
        }
        do {
            var r: ModInt = 3
            r -= r
            XCTAssertEqual(r.value, 0)
        }
    }
    
    func testTimesEqual() {
        do {
            let n = modulus - 1
            var r: ModInt = .init(n)
            r *= r
            XCTAssertEqual(r.value, (n * n) % modulus)
        }
        do {
            let n = modulus - 1
            var r: ModInt = .init(n)
            r *= 2
            XCTAssertEqual(r.value, (n + n) % modulus)
        }
    }
}
