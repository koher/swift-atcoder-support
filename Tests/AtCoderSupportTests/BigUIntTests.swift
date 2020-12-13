import XCTest
@testable import AtCoderSupport

final class BigUIntTests: XCTestCase {
    func testInitWithString() {
        do {
            let a: BigUInt? = BigUInt("1267650600228229401496703205376")
            XCTAssertEqual(a, .pow(2, 100))
            XCTAssertEqual(a?.description, "1267650600228229401496703205376")
        }
        do {
            let a: BigUInt? = BigUInt("36893488147419103230")
            XCTAssertEqual(a?.description, "36893488147419103230")
        }
        do {
            let a: BigUInt? = BigUInt("0")
            XCTAssertEqual(a, 0)
            XCTAssertEqual(a?.description, "0")
        }
        do {
            let a: BigUInt? = BigUInt("ABC")
            XCTAssertNil(a)
        }
    }
    
    func testInitWithStringProtocol() {
        do {
            let a: BigUInt? = BigUInt("X1267650600228229401496703205376".dropFirst())
            XCTAssertEqual(a, .pow(2, 100))
            XCTAssertEqual(a?.description, "1267650600228229401496703205376")
        }
        do {
            let a: BigUInt? = BigUInt("X36893488147419103230".dropFirst())
            XCTAssertEqual(a?.description, "36893488147419103230")
        }
        do {
            let a: BigUInt? = BigUInt("X0".dropFirst())
            XCTAssertEqual(a, 0)
            XCTAssertEqual(a?.description, "0")
        }
        do {
            let a: BigUInt? = BigUInt("XABC".dropFirst())
            XCTAssertNil(a)
        }
    }
    
    func testDescription() {
        do {
            let a: BigUInt = 42
            XCTAssertEqual(a.description, "42")
        }
        do {
            if MemoryLayout<UInt>.size == 8 {
                let a: BigUInt = .init(UInt.max) + 1
                XCTAssertEqual(a.description, "18446744073709551616")
            }
        }
        do {
            let a: BigUInt = .pow(2, 512)
            XCTAssertEqual(a.description, "13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096")
        }
    }
    
    func testLessThan() {
        do {
            let a: BigUInt = 2
            let b: BigUInt = 3
            XCTAssertTrue(a < b)
        }
        do {
            let a: BigUInt = 3
            let b: BigUInt = 2
            XCTAssertFalse(a < b)
        }
        do {
            let a: BigUInt = 2
            let b: BigUInt = 2
            XCTAssertFalse(a < b)
        }
        do {
            let a: BigUInt = 0
            let b: BigUInt = 1
            XCTAssertTrue(a < b)
        }
        do {
            let a: BigUInt = 1
            let b: BigUInt = 0
            XCTAssertFalse(a < b)
        }
        do {
            let a: BigUInt = 0
            let b: BigUInt = 0
            XCTAssertFalse(a < b)
        }
        do {
            let a: BigUInt = BigUInt(UInt.max)
            let b: BigUInt = BigUInt(UInt.max) + 1
            XCTAssertTrue(a < b)
        }
        do {
            let a: BigUInt = BigUInt(UInt.max) + 1
            let b: BigUInt = BigUInt(UInt.max)
            XCTAssertFalse(a < b)
        }
    }
    
    func testPlus() {
        do {
            let a: BigUInt = 2
            let b: BigUInt = 3
            XCTAssertEqual(a + b, 5)
        }
        do {
            if MemoryLayout<UInt>.size == 8 {
                let a: BigUInt = .init(UInt.max)
                XCTAssertEqual(a + a, BigUInt("36893488147419103230"))
            }
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: BigUInt = .pow(2, 511)
            XCTAssertEqual(a + b, BigUInt("20111711894913895649361037497308769191219048730888590066585342165582646045110320465202811447250355141535047787279729076280630824217919854919650473509126144"))
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: BigUInt = .pow(2, 256)
            XCTAssertEqual(a + b, BigUInt("13407807929942597099574024998205846127479365820592393377723561443721764030073662768891111614362326998675040546094339320838419523375986027530441562135724032"))
        }
    }
    
    func testMinus() {
        do {
            let a: BigUInt = 3
            let b: BigUInt = 2
            XCTAssertEqual(a - b, 1)
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: BigUInt = .pow(2, 511)
            XCTAssertEqual(a - b, BigUInt("6703903964971298549787012499102923063739682910296196688861780721860882015036773488400937149083451713845015929093243025426876941405973284973216824503042048"))
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: BigUInt = .pow(2, 256)
            XCTAssertEqual(a - b, BigUInt("13407807929942597099574024998205846127479365820592393377723561443721764030073431184712636981971479856705023170278632780869088242247907112362425735876444160"))
        }
    }
    
    func testTimes() {
        do {
            let a: BigUInt = 2
            let b: BigUInt = 3
            XCTAssertEqual(a * b, 6)
        }
        do {
            var a: BigUInt = 1
            for _ in 1 ... 512 {
                a *= 2
            }
            XCTAssertEqual(a, BigUInt("13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096"))
            XCTAssertEqual(a.description, "13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096")

        }
        do {
            if MemoryLayout<UInt>.size == 8 {
                let a: BigUInt = BigUInt(UInt.max)
                XCTAssertEqual(a * a, BigUInt("340282366920938463426481119284349108225"))
                XCTAssertEqual(a * a * a, BigUInt("6277101735386680762814942322444851025767571854389858533375"))
                XCTAssertEqual(a * a * a * a, BigUInt("115792089237316195398462578067141184799968521174335529155754622898352762650625"))
            }
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: BigUInt = .pow(3, 128)
            XCTAssertEqual(a * b, BigUInt("158080530276890286122762315299176464969805626656606331308148944306682275662269021286526559033136370664500949844684512051241289100907713600649203674734260105986549738626670637536231374508536832139371969829181384032256"))
        }
    }
    
    func testDivide() {
        do {
            let a: BigUInt = 7
            let b: UInt = 3
            XCTAssertEqual(a / b, 2)
        }
        do {
            let a: BigUInt = BigUInt(UInt.max) + BigUInt(UInt.max)
            let b: UInt = 2
            XCTAssertEqual(a / b, BigUInt(UInt.max))
        }
        do {
            let a: BigUInt = BigUInt(UInt.max) + BigUInt(UInt.max)
            let b: UInt = .max
            XCTAssertEqual(a / b, 2)
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: UInt = 2
            XCTAssertEqual(a / b, .pow(2, 511))
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: UInt = 1 << 31
            XCTAssertEqual(a / b, .pow(2, 481))
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: UInt = 123456789
            XCTAssertEqual(a / b, BigUInt("108603245220824568016053171431551213659698907450058444155092689505489763143552575118423615392806817838831300384675370512461278114174398055553134862"))
        }
    }
    
    func testRemainder() {
        do {
            let a: BigUInt = 6
            let b: UInt = 3
            XCTAssertEqual(a % b, 0)
        }
        do {
            let a: BigUInt = 7
            let b: UInt = 3
            XCTAssertEqual(a % b, 1)
        }
        do {
            let a: BigUInt = 8
            let b: UInt = 3
            XCTAssertEqual(a % b, 2)
        }
        do {
            let a: BigUInt = .pow(2, 100)
            XCTAssertEqual(a % 2, 0)
            XCTAssertEqual(a % 4, 0)
            XCTAssertEqual(a % 8, 0)
            XCTAssertEqual(a % 16, 0)
            XCTAssertEqual(a % 1 << 31, 0)
        }
        do {
            let a: BigUInt = BigUInt(UInt.max) * 10 + 1
            let b: UInt = .max
            XCTAssertEqual(a % b, 1)
        }
        do {
            let a: BigUInt = .pow(2, 512)
            let b: UInt = 123456789
            XCTAssertEqual(a % b, 59605978)
        }
        do {
            let a: BigUInt = BigUInt("1858445835049782285757026664950217712384527500000000")!
            let b: UInt = 998244353
            XCTAssertEqual(a % b, 951633476)
        }
    }
    
    func testRightShift() {
        do {
            let a: BigUInt = 7
            XCTAssertEqual(a >> 1, 3)
        }
        do {
            let a: BigUInt = .pow(3, 128)
            XCTAssertEqual(a >> 1, BigUInt("5895092288869291585760436430706259332839105796137920554548480"))
        }
        do {
            let a: BigUInt = .pow(3, 256)
            XCTAssertEqual(a >> 100, BigUInt("109658333575606304232296601271443558971917571123765177973041041632575963156099137956140949597"))
        }
        do {
            let a: BigUInt = .pow(3, 256)
            XCTAssertEqual(a >> 200, BigUInt("86505172289480461362381148729559697079984195950879243965911039"))
        }
        do {
            let a: BigUInt = .pow(3, 256)
            XCTAssertEqual(a >> 1000, 0)
        }
    }
    
    func testPow() {
        do {
            let a: BigUInt = 2
            let b: UInt = 100
            let r: BigUInt = .pow(a, b)
            XCTAssertEqual(r, (1 ... 100).reduce(1 as BigUInt) { r, _ in r * 2 })
            XCTAssertEqual(r.description, "1267650600228229401496703205376")
        }
        do {
            let a: BigUInt = 2
            let b: UInt = 512
            let r: BigUInt = .pow(a, b)
            XCTAssertEqual(r.description, "13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096")
        }
    }

}
