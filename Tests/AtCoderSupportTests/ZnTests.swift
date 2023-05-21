import XCTest
@testable import AtCoderSupport

final class ZnTests: XCTestCase {
    func testNegation() {
        assert(-Zn(safe: 5) == Zn(safe: -5))
        assert(-Zn(safe: 0) == 0)
    }

    func testAddition() {
        assert((Zn(safe: 3) + Zn(safe: 5)).n == Zn(safe: 8).n)
        assert((Zn(safe: 5) + Zn(safe: -4)).n == Zn(safe: 1).n)
    }

    func testSubtraction() {
        assert(Zn(safe: 5) - Zn(safe: 3) == Zn(safe: 2))
        assert(Zn(safe: 3) - Zn(safe: 5) == Zn(safe: -2))
        assert(Zn(safe: 3) - Zn(safe: 3) == Zn(safe: 0))
    }

    func testMultiplication() {
        assert(Zn(safe: 3) * Zn(safe: 4) == Zn(safe: 12))
        assert(Zn(safe: 3) * Zn(safe: -4) == Zn(safe: -12))
        assert(Zn(safe: -3) * Zn(safe: 4) == Zn(safe: -12))
        assert(Zn(safe: -3) * Zn(safe: -4) == Zn(safe: 12))
        assert(Zn(safe: 3) * Zn(safe: 0) == Zn(safe: 0))
        assert(Zn(safe: 0) * Zn(safe: 3) == Zn(safe: 0))
        assert(Zn(safe: 0) * Zn(safe: 0) == Zn(safe: 0))
    }

    func testDivision() {
        assert(Zn(safe: 3) / Zn(safe: 2) * Zn(safe: 2) == Zn(safe: 3))
        assert(Zn(safe: 3) / Zn(safe: -2) * Zn(safe: -2) == Zn(safe: 3))
        assert(Zn(safe: 3) / Zn(safe: 1) * Zn(safe: 1) == Zn(safe: 3))
        assert(Zn(safe: 3) / Zn(safe: -1) * Zn(safe: -1) == Zn(safe: 3))
        assert(Zn(safe: 0) / Zn(safe: 3) * Zn(safe: 3) == Zn(safe: 0))
    }

    func testPower() {
        assert(Zn(safe: 2).pow(0) == Zn(safe: 1))
        assert(Zn(safe: 2).pow(1) == Zn(safe: 2))
        assert(Zn(safe: 2).pow(2) == Zn(safe: 2 * 2))
        assert(Zn(safe: 2).pow(3) == Zn(safe: 2 * 2 * 2))
        assert(Zn(safe: 2).pow(4) == Zn(safe: 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(5) == Zn(safe: 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(6) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(7) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(8) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2))
        assert(Zn(safe: 2).pow(-1) == Zn(safe: 2).inverse)
        assert(Zn(safe: 2).pow(-2) == Zn(safe: 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-3) == Zn(safe: 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-4) == Zn(safe: 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-5) == Zn(safe: 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-6) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-7) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 2).pow(-8) == Zn(safe: 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2).inverse)
        assert(Zn(safe: 3).pow(0) == Zn(safe: 1))
        assert(Zn(safe: 3).pow(1) == Zn(safe: 3))
        assert(Zn(safe: 3).pow(2) == Zn(safe: 3 * 3))
        assert(Zn(safe: 3).pow(3) == Zn(safe: 3 * 3 * 3))
        assert(Zn(safe: 3).pow(4) == Zn(safe: 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(5) == Zn(safe: 3 * 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(6) == Zn(safe: 3 * 3 * 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(7) == Zn(safe: 3 * 3 * 3 * 3 * 3 * 3 * 3))
        assert(Zn(safe: 3).pow(8) == Zn(safe: 3 * 3 * 3 * 3 * 3 * 3 * 3 * 3))
    }

    func testInverse() {
        assert(Zn(safe: 1).inverse * Zn(safe: 1) == Zn(safe: 1))
        assert(Zn(safe: 2).inverse * Zn(safe: 2) == Zn(safe: 1))
        assert(Zn(safe: 3).inverse * Zn(safe: 3) == Zn(safe: 1))
        assert(Zn(safe: 4).inverse * Zn(safe: 4) == Zn(safe: 1))
        assert(Zn(safe: 5).inverse * Zn(safe: 5) == Zn(safe: 1))
        assert(Zn(safe: 6).inverse * Zn(safe: 6) == Zn(safe: 1))
        assert(Zn(safe: 7).inverse * Zn(safe: 7) == Zn(safe: 1))
        assert(Zn(safe: 8).inverse * Zn(safe: 8) == Zn(safe: 1))
    }
}