import XCTest
@testable import AtCoderSupport

final class VectorsTests: XCTestCase {
    func testPlus() {
        XCTAssertEqual((2, 3) + (5, 7), (7, 10))
        XCTAssertEqual((2.0, 3.0) + (5.0, 7.0), (7.0, 10.0))
    }
    
    func testMinus() {
        XCTAssertEqual((2, 3) - (5, 7), (-3, -4))
        XCTAssertEqual((2.0, 3.0) - (5.0, 7.0), (-3.0, -4.0))
    }
    
    func testTimes() {
        XCTAssertEqual((2, 3) * 5, (10, 15))
        XCTAssertEqual((2.0, 3.0) * 5.0, (10.0, 15.0))
    }
    
    func testDivide() {
        XCTAssertEqual((12, 15) / 3, (4, 5))
        XCTAssertEqual((12.0, 15.0) / 3.0, (4.0, 5.0))
    }

    func testPlusEqual() {
        do {
            var a = (2, 3)
            a += (5, 7)
            XCTAssertEqual(a, (7, 10))
        }
        do {
            var a = (2.0, 3.0)
            a += (5.0, 7.0)
            XCTAssertEqual(a, (7.0, 10.0))
        }
    }
    
    func testMinusEqual() {
        do {
            var a = (2, 3)
            a -= (5, 7)
            XCTAssertEqual(a, (-3, -4))
        }
        do {
            var a = (2.0, 3.0)
            a -= (5.0, 7.0)
            XCTAssertEqual(a, (-3.0, -4.0))
        }
    }
    
    func testTimesEqual() {
        do {
            var a = (2, 3)
            a *= 5
            XCTAssertEqual(a, (10, 15))
        }
        do {
            var a = (2.0, 3.0)
            a *= 5.0
            XCTAssertEqual(a, (10.0, 15.0))
        }
    }
    
    func testDivideEqual() {
        do {
            var a = (12, 15)
            a /= 3
            XCTAssertEqual(a, (4, 5))
        }
        do {
            var a = (12.0, 15.0)
            a /= 3.0
            XCTAssertEqual(a, (4.0, 5.0))
        }
    }
}

// FIXME: SE-0283 でタプルが Equatable になったら除去
private func XCTAssertEqual<T: Equatable>(_ expression1: (T, T), _ expression2: (T, T)) {
    XCTAssertEqual(expression1.0, expression2.0)
    XCTAssertEqual(expression1.1, expression2.1)
}
