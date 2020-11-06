import XCTest
@testable import AtCoderSupport

final class ModOperatorsTests: XCTestCase {
    func testPlus() {
        XCTAssertEqual(1 %+ 1, 2)
        XCTAssertEqual((Int.modulus - 1) %+ 1, 0)
        XCTAssertEqual((Int.modulus - 2) %+ 1, Int.modulus - 1)
        XCTAssertEqual((Int.modulus - 1) %+ (Int.modulus - 1), Int.modulus - 2)
        XCTAssertEqual(-2 %+ 1, Int.modulus - 1)
        XCTAssertEqual(-(Int.modulus - 1) %+ -2, Int.modulus - 1)
        
        XCTAssertEqual((UInt.modulus - 1) %+ (UInt.modulus - 1), UInt.modulus - 2)
    }
    
    func testMinus() {
        XCTAssertEqual(5 %- 3, 2)
        XCTAssertEqual(1 %- 2, Int.modulus - 1)
        XCTAssertEqual(1 %- (Int.modulus - 1), 2)
        XCTAssertEqual((Int.modulus - 3) %- (Int.modulus - 2), Int.modulus - 1)
        XCTAssertEqual(-2 %- 3, Int.modulus - 5)
        XCTAssertEqual(-(Int.modulus - 1) %- 2, Int.modulus - 1)

        XCTAssertEqual((UInt.modulus - 3) %- (UInt.modulus - 2), UInt.modulus - 1)
    }
    
    func testTimes() {
        XCTAssertEqual(2 %* 3, 6)
        XCTAssertEqual((Int.modulus - 1) %* 5, Int.modulus - 5)
        XCTAssertEqual((Int.modulus / 2) %* 2, Int.modulus - 1)
        XCTAssertEqual((Int.modulus - 1) %* (Int.modulus - 1), ((Int.modulus - 1) * (Int.modulus - 1)) % Int.modulus)
        XCTAssertEqual(-2 %* 3, Int.modulus - 6)
        XCTAssertEqual(2 %* -3, Int.modulus - 6)
        XCTAssertEqual((Int.modulus - 1) %* -2, 2)

        XCTAssertEqual((UInt.modulus - 1) %* (UInt.modulus - 1), ((UInt.modulus - 1) * (UInt.modulus - 1)) % UInt.modulus)
    }
    
    func testDivide() {
        XCTAssertEqual(6 %/ 3, 2)
        XCTAssertEqual(((Int.modulus - 1) * 6) %/ ((Int.modulus - 1) * 2), 3)
        //XCTAssertEqual((Int.modulus * 6) %/ (Int.modulus * 2), 3)

        XCTAssertEqual(((UInt.modulus - 1) * 6) %/ ((UInt.modulus - 1) * 2), 3)
    }
    
    func testPlusEqual() {
        do {
            var a = Int.modulus - 1
            a %+= Int.modulus - 1
            XCTAssertEqual(a, Int.modulus - 2)
        }
        do {
            var a = UInt.modulus - 1
            a %+= UInt.modulus - 1
            XCTAssertEqual(a, UInt.modulus - 2)
        }
    }
    
    func testMinusEqual() {
        do {
            var a = Int.modulus - 3
            a %-= Int.modulus - 2
            XCTAssertEqual(a, Int.modulus - 1)
        }
        do {
            var a = UInt.modulus - 3
            a %-= UInt.modulus - 2
            XCTAssertEqual(a, UInt.modulus - 1)
        }
    }
    
    func testTimesEqual() {
        do {
            var a = Int.modulus - 1
            a %*= Int.modulus - 1
            XCTAssertEqual(a, ((Int.modulus - 1) * (Int.modulus - 1)) % Int.modulus)
        }
        do {
            var a = UInt.modulus - 1
            a %*= UInt.modulus - 1
            XCTAssertEqual(a, ((UInt.modulus - 1) * (UInt.modulus - 1)) % UInt.modulus)
        }
    }
    
    func testDivideEqual() {
        do {
            var a = (Int.modulus - 1) * 6
            a %/= (Int.modulus - 1) * 2
            XCTAssertEqual(a, 3)
        }
        do {
            var a = (UInt.modulus - 1) * 6
            a %/= (UInt.modulus - 1) * 2
            XCTAssertEqual(a, 3)
        }
    }
}
