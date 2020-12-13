import XCTest
@testable import AtCoderSupport

final class BigIntTests: XCTestCase {
    func testInitWithString() {
        do {
            let a: BigInt? = BigInt("1267650600228229401496703205376")
            XCTAssertEqual(a, .pow(2, 100))
            XCTAssertEqual(a?.description, "1267650600228229401496703205376")
        }
        do {
            let a: BigInt? = BigInt("-1267650600228229401496703205376")
            XCTAssertEqual(a, -.pow(2, 100))
            XCTAssertEqual(a?.description, "-1267650600228229401496703205376")
        }
        do {
            let a: BigInt? = BigInt("36893488147419103230")
            XCTAssertEqual(a?.description, "36893488147419103230")
        }
        do {
            let a: BigInt? = BigInt("0")
            XCTAssertEqual(a, 0)
        }
        do {
            let a: BigInt? = BigInt("-0")
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
            XCTAssertEqual(a?.description, "1267650600228229401496703205376")
        }
        do {
            let a: BigInt? = BigInt("X-1267650600228229401496703205376".dropFirst())
            XCTAssertEqual(a, -.pow(2, 100))
            XCTAssertEqual(a?.description, "-1267650600228229401496703205376")
        }
        do {
            let a: BigInt? = BigInt("X36893488147419103230".dropFirst())
            XCTAssertEqual(a?.description, "36893488147419103230")
        }
        do {
            let a: BigInt? = BigInt("X0".dropFirst())
            XCTAssertEqual(a, 0)
        }
        do {
            let a: BigInt? = BigInt("X-0".dropFirst())
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
        do {
            if MemoryLayout<UInt>.size == 8 {
                let a: BigUInt = .init(UInt.max) + 1
                XCTAssertEqual(a.description, "18446744073709551616")
            }
        }
        do {
            let a: BigInt = .pow(2, 512)
            XCTAssertEqual(a.description, "13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096")
        }
        do {
            let a: BigInt = .pow(-2, 513)
            XCTAssertEqual(a.description, "-26815615859885194199148049996411692254958731641184786755447122887443528060147093953603748596333806855380063716372972101707507765623893139892867298012168192")
        }
    }
    
    func testPlus() {
        do {
            let a: BigInt = 2
            let b: BigInt = 3
            XCTAssertEqual(a + b, 5)
        }
        do {
            let a: BigInt = 2
            let b: BigInt = -3
            XCTAssertEqual(a + b, -1)
        }
        do {
            let a: BigInt = -2
            let b: BigInt = 3
            XCTAssertEqual(a + b, 1)
        }
        do {
            let a: BigInt = -2
            let b: BigInt = -3
            XCTAssertEqual(a + b, -5)
        }
        do {
            let a: BigInt = 3
            let b: BigInt = 2
            XCTAssertEqual(a + b, 5)
        }
        do {
            let a: BigInt = 3
            let b: BigInt = -2
            XCTAssertEqual(a + b, 1)
        }
        do {
            let a: BigInt = -3
            let b: BigInt = 2
            XCTAssertEqual(a + b, -1)
        }
        do {
            let a: BigInt = -3
            let b: BigInt = -2
            XCTAssertEqual(a + b, -5)
        }
        do {
            if MemoryLayout<Int>.size == 8 {
                let a: BigInt = .init(Int.max)
                XCTAssertEqual(a + a, BigInt("18446744073709551614"))
                XCTAssertEqual(a + a + a, BigInt("27670116110564327421"))
                XCTAssertEqual(a + a + a + a, BigInt("36893488147419103228"))
                XCTAssertEqual(a + a + a + a + a, BigInt("46116860184273879035"))
            }
        }
    }
    
    func testMinus() {
        do {
            let a: BigInt = 2
            let b: BigInt = 3
            XCTAssertEqual(a - b, -1)
        }
        do {
            let a: BigInt = 2
            let b: BigInt = -3
            XCTAssertEqual(a - b, 5)
        }
        do {
            let a: BigInt = -2
            let b: BigInt = 3
            XCTAssertEqual(a - b, -5)
        }
        do {
            let a: BigInt = -2
            let b: BigInt = -3
            XCTAssertEqual(a - b, 1)
        }
        do {
            let a: BigInt = 3
            let b: BigInt = 2
            XCTAssertEqual(a - b, 1)
        }
        do {
            let a: BigInt = 3
            let b: BigInt = -2
            XCTAssertEqual(a - b, 5)
        }
        do {
            let a: BigInt = -3
            let b: BigInt = 2
            XCTAssertEqual(a - b, -5)
        }
        do {
            let a: BigInt = -3
            let b: BigInt = -2
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
            let b: Int = 3
            XCTAssertEqual(a / b, 2)
        }
        do {
            let a: BigInt = -7
            let b: Int = 3
            XCTAssertEqual(a / b, -2)
        }
    }
    
    func testRemainder() {
        do {
            let a: BigInt = 6
            let b: Int = 3
            XCTAssertEqual(a % b, 0)
        }
        do {
            let a: BigInt = 7
            let b: Int = 3
            XCTAssertEqual(a % b, 1)
        }
        do {
            let a: BigInt = 8
            let b: Int = 3
            XCTAssertEqual(a % b, 2)
        }
        do {
            let a: BigInt = -6
            let b: Int = 3
            XCTAssertEqual(a % b, 0)
        }
        do {
            let a: BigInt = -7
            let b: Int = 3
            XCTAssertEqual(a % b, -1)
        }
        do {
            let a: BigInt = -8
            let b: Int = 3
            XCTAssertEqual(a % b, -2)
        }
        do {
            let a: BigInt = BigInt("1858445835049782285757026664950217712384527500000000")!
            let b: Int = 998244353
            XCTAssertEqual(a % b, 951633476)
        }
        do { // sign
            do {
                let a: BigInt = 11
                let b: Int = 3
                XCTAssertEqual(a % b, 11 % 3)
            }
            do {
                let a: BigInt = -11
                let b: Int = 3
                XCTAssertEqual(a % b, -11 % 3)
            }
            do {
                let a: BigInt = 11
                let b: Int = -3
                XCTAssertEqual(a % b, 11 % -3)
            }
            do {
                let a: BigInt = -11
                let b: Int = -3
                XCTAssertEqual(a % b, -11 % -3)
            }
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
            let b: Int = 512
            let r: BigInt = .pow(a, b)
            XCTAssertEqual(r.description, "13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096")
        }
    }
}
