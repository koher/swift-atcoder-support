import XCTest
@testable import AtCoderSupport

final class PermutationsTests: XCTestCase {
    func testPermutations() {
        do {
            let r = Set([Int]().permutations())
            XCTAssertEqual(r.count, 1)
            XCTAssertTrue(r.contains([]))
        }
        do {
            let r = Set([1].permutations())
            XCTAssertEqual(r.count, 1)
            XCTAssertTrue(r.contains([1]))
        }
        do {
            let r = Set([1, 2].permutations())
            XCTAssertEqual(r.count, 2)
            XCTAssertTrue(r.contains([1, 2]))
            XCTAssertTrue(r.contains([2, 1]))
        }
        do {
            let r = Set([1, 2, 3].permutations())
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains([1, 2, 3]))
            XCTAssertTrue(r.contains([1, 3, 2]))
            XCTAssertTrue(r.contains([2, 1, 3]))
            XCTAssertTrue(r.contains([2, 3, 1]))
            XCTAssertTrue(r.contains([3, 1, 2]))
            XCTAssertTrue(r.contains([3, 2, 1]))
        }
        do {
            let r = Set([1, 2, 3, 4].permutations())
            XCTAssertEqual(r.count, 24)
            XCTAssertTrue(r.contains([1, 2, 3, 4]))
            XCTAssertTrue(r.contains([1, 2, 4, 3]))
            XCTAssertTrue(r.contains([1, 3, 2, 4]))
            XCTAssertTrue(r.contains([1, 3, 4, 2]))
            XCTAssertTrue(r.contains([1, 4, 2, 3]))
            XCTAssertTrue(r.contains([1, 4, 3, 2]))
            XCTAssertTrue(r.contains([2, 1, 3, 4]))
            XCTAssertTrue(r.contains([2, 1, 4, 3]))
            XCTAssertTrue(r.contains([2, 3, 1, 4]))
            XCTAssertTrue(r.contains([2, 3, 4, 1]))
            XCTAssertTrue(r.contains([2, 4, 1, 3]))
            XCTAssertTrue(r.contains([2, 4, 3, 1]))
            XCTAssertTrue(r.contains([3, 1, 2, 4]))
            XCTAssertTrue(r.contains([3, 1, 4, 2]))
            XCTAssertTrue(r.contains([3, 2, 1, 4]))
            XCTAssertTrue(r.contains([3, 2, 4, 1]))
            XCTAssertTrue(r.contains([3, 4, 1, 2]))
            XCTAssertTrue(r.contains([3, 4, 2, 1]))
            XCTAssertTrue(r.contains([4, 1, 2, 3]))
            XCTAssertTrue(r.contains([4, 1, 3, 2]))
            XCTAssertTrue(r.contains([4, 2, 1, 3]))
            XCTAssertTrue(r.contains([4, 2, 3, 1]))
            XCTAssertTrue(r.contains([4, 3, 1, 2]))
            XCTAssertTrue(r.contains([4, 3, 2, 1]))
        }
        do { // `Sequence`s of `Character`s
            let r = Set("ABC".permutations())
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains(["A", "B", "C"]))
            XCTAssertTrue(r.contains(["A", "C", "B"]))
            XCTAssertTrue(r.contains(["B", "A", "C"]))
            XCTAssertTrue(r.contains(["B", "C", "A"]))
            XCTAssertTrue(r.contains(["C", "A", "B"]))
            XCTAssertTrue(r.contains(["C", "B", "A"]))
        }
        do { // Reverse order inputs
            let r = Set([3, 2, 1].permutations())
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains([1, 2, 3]))
            XCTAssertTrue(r.contains([1, 3, 2]))
            XCTAssertTrue(r.contains([2, 1, 3]))
            XCTAssertTrue(r.contains([2, 3, 1]))
            XCTAssertTrue(r.contains([3, 1, 2]))
            XCTAssertTrue(r.contains([3, 2, 1]))
        }
        do { // Collections but `Array`s
            let r = Set([0, 1, 2, 3, 4][1 ..< 4].permutations())
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains([1, 2, 3]))
            XCTAssertTrue(r.contains([1, 3, 2]))
            XCTAssertTrue(r.contains([2, 1, 3]))
            XCTAssertTrue(r.contains([2, 3, 1]))
            XCTAssertTrue(r.contains([3, 1, 2]))
            XCTAssertTrue(r.contains([3, 2, 1]))
        }
    }
    
    func testNpr() {
        XCTAssertEqual(npr(5, 0), 1)
        XCTAssertEqual(npr(5, 1), 5)
        XCTAssertEqual(npr(5, 2), 20)
        XCTAssertEqual(npr(5, 3), 60)
        XCTAssertEqual(npr(5, 4), 120)
        XCTAssertEqual(npr(5, 5), 120)
        
        XCTAssertEqual(npr(0, 0), 1)

        XCTAssertEqual(npr(5, 0, modulus: 7), 1)
        XCTAssertEqual(npr(5, 1, modulus: 7), 5)
        XCTAssertEqual(npr(5, 2, modulus: 7), 6)
        XCTAssertEqual(npr(5, 3, modulus: 7), 4)
        XCTAssertEqual(npr(5, 4, modulus: 7), 1)
        XCTAssertEqual(npr(5, 5, modulus: 7), 1)
        
        XCTAssertEqual(npr(5 as UInt, 3), 60)
    }
    
    #if !DEBUG
    func testPermutatinsPerformance() {
        measure {
            let r = (1 ... 8).permutations()
            XCTAssertEqual(r.count, 40320)
        }
    }
    #endif
}
