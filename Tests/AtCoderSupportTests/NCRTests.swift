import XCTest
@testable import AtCoderSupport

final class NCRTests: XCTestCase {
    func testFactorial() {
        let a: NCR = .init(maxN: 10000, modulus: 998244353)
        
        XCTAssertEqual(a.factorial(of: 0), 1)
        XCTAssertEqual(a.factorial(of: 1), 1)
        XCTAssertEqual(a.factorial(of: 2), 2)
        XCTAssertEqual(a.factorial(of: 3), 6)
        XCTAssertEqual(a.factorial(of: 4), 24)
        XCTAssertEqual(a.factorial(of: 5), 120)
        XCTAssertEqual(a.factorial(of: 6), 720)
        XCTAssertEqual(a.factorial(of: 7), 5_040)
        XCTAssertEqual(a.factorial(of: 8), 40_320)
        XCTAssertEqual(a.factorial(of: 9), 362_880)
        
        XCTAssertEqual(a.factorial(of: 18), 6_402_373_705_728_000 % 998244353)
        
        XCTAssertEqual(a.factorial(of: 10000), 777990065)
    }
    
    func testNPR() {
        let a: NCR = .init(maxN: 10000, modulus: 998244353)

        XCTAssertEqual(a.npr(0, 0), 1)
        XCTAssertEqual(a.npr(1, 1), 1)
        XCTAssertEqual(a.npr(2, 2), 2)
        XCTAssertEqual(a.npr(3, 3), 6)
        XCTAssertEqual(a.npr(4, 4), 24)
        XCTAssertEqual(a.npr(5, 5), 120)
        XCTAssertEqual(a.npr(6, 6), 720)
        XCTAssertEqual(a.npr(7, 7), 5_040)
        XCTAssertEqual(a.npr(8, 8), 40_320)
        XCTAssertEqual(a.npr(9, 9), 362_880)
        
        XCTAssertEqual(a.npr(18, 18), 6_402_373_705_728_000 % 998244353)
        
        for n in 0 ... 9 {
            for r in 0 ... n {
                XCTAssertEqual(a.npr(n, r), a.factorial(of: n) / a.factorial(of: n - r))
            }
        }
        
        XCTAssertEqual(a.npr(18, 7), 6_402_373_705_728_000 / 39_916_800 % 998244353)
        
        XCTAssertEqual(a.npr(10000, 2000), 168757127)
    }
    
    func testNCR() {
        let a: NCR = .init(maxN: 10000, modulus: 998244353)
        
        XCTAssertEqual(a.ncr(0, 0), 1)
        
        for n in 0 ... 9 {
            for r in 0 ... n {
                XCTAssertEqual(a.ncr(n, r), a.factorial(of: n) / (a.factorial(of: n - r) * a.factorial(of: r)))
            }
        }
        
        XCTAssertEqual(a.ncr(18, 7), 6_402_373_705_728_000 / (39_916_800 * 5_040) % 998244353)

        XCTAssertEqual(a.ncr(10000, 2000), 96147199)
        
        XCTAssertEqual(a.ncr(10000, 0), 1)
        XCTAssertEqual(a.ncr(10000, 1), 10000)
        XCTAssertEqual(a.ncr(10000, 9999), 10000)
        XCTAssertEqual(a.ncr(10000, 10000), 1)
    }
    
    func testCallAsFunction() {
        let ncr: NCR = .init(maxN: 10000, modulus: 998244353)
        
        XCTAssertEqual(ncr(0, 0), 1)
        
        for n in 0 ... 9 {
            for r in 0 ... n {
                XCTAssertEqual(ncr(n, r), ncr.factorial(of: n) / (ncr.factorial(of: n - r) * ncr.factorial(of: r)))
            }
        }
        
        XCTAssertEqual(ncr(18, 7), 6_402_373_705_728_000 / (39_916_800 * 5_040) % 998244353)

        XCTAssertEqual(ncr(10000, 2000), 96147199)
        
        XCTAssertEqual(ncr(10000, 0), 1)
        XCTAssertEqual(ncr(10000, 1), 10000)
        XCTAssertEqual(ncr(10000, 9999), 10000)
        XCTAssertEqual(ncr(10000, 10000), 1)
    }
}
