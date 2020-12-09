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
    
    func testInitWithStringProtocol() {
        do {
            let a: BigInt? = BigInt("X1267650600228229401496703205376".dropFirst())
            XCTAssertEqual(a, .pow(2, 100))
        }
        do {
            let a: BigInt? = BigInt("X-1267650600228229401496703205376".dropFirst())
            XCTAssertEqual(a, -.pow(2, 100))
        }
        do {
            let a: BigInt? = BigInt("X0".dropFirst())
            XCTAssertEqual(a, 0)
        }
        do {
            let a: BigInt? = BigInt("XABC".dropFirst())
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
        do {
            let a: BigInt = BigInt("1858445835049782285757026664950217712384527500000000")!
            let b: BigInt = 998244353
            XCTAssertEqual(a % b, 951633476)
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
        do {
            let a: BigInt = 2
            let b: Int = 100
            let r: BigInt = .pow(a, b)
            XCTAssertEqual(r, (1 ... 100).reduce(1 as BigInt) { r, _ in r * 2 })
            XCTAssertEqual(r.description, "1267650600228229401496703205376")
        }
        do {
            let a: BigInt = 2
            let b: Int = 512
            let r: BigInt = .pow(a, b)
            XCTAssertEqual(r.description, "13​407​807​929​942​597​099​574​024​998​205​846​127​479​365​820​592​393​377​723​561​443​721​764​030​073​546​976​801​874​298​166​903​427​690​031​858​186​486​050​853​753​882​811​946​569​946​433​649​006​084​096")
        }
    }
}
