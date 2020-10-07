import XCTest
@testable import AtCoderSupport

final class PermutationsTests: XCTestCase {
    func testPermutations() {
        do {
            let r = Set(permutations(of: [] as [Int]))
            XCTAssertEqual(r.count, 1)
            XCTAssertTrue(r.contains([]))
        }
        do {
            let r = Set(permutations(of: [1]))
            XCTAssertEqual(r.count, 1)
            XCTAssertTrue(r.contains([1]))
        }
        do {
            let r = Set(permutations(of: [1, 2]))
            XCTAssertEqual(r.count, 2)
            XCTAssertTrue(r.contains([1, 2]))
            XCTAssertTrue(r.contains([2, 1]))
        }
        do {
            let r = Set(permutations(of: [1, 2, 3]))
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains([1, 2, 3]))
            XCTAssertTrue(r.contains([1, 3, 2]))
            XCTAssertTrue(r.contains([2, 1, 3]))
            XCTAssertTrue(r.contains([2, 3, 1]))
            XCTAssertTrue(r.contains([3, 1, 2]))
            XCTAssertTrue(r.contains([3, 2, 1]))
        }
        do {
            let r = Set(permutations(of: [1, 2, 3, 4]))
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
        do { // Collection of `Character`s
            let r = Set(permutations(of: Array("ABC")))
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains(["A", "B", "C"]))
            XCTAssertTrue(r.contains(["A", "C", "B"]))
            XCTAssertTrue(r.contains(["B", "A", "C"]))
            XCTAssertTrue(r.contains(["B", "C", "A"]))
            XCTAssertTrue(r.contains(["C", "A", "B"]))
            XCTAssertTrue(r.contains(["C", "B", "A"]))
        }
        do { // Reverse order inputs
            let r = Set(permutations(of: [3, 2, 1]))
            XCTAssertEqual(r.count, 6)
            XCTAssertTrue(r.contains([1, 2, 3]))
            XCTAssertTrue(r.contains([1, 3, 2]))
            XCTAssertTrue(r.contains([2, 1, 3]))
            XCTAssertTrue(r.contains([2, 3, 1]))
            XCTAssertTrue(r.contains([3, 1, 2]))
            XCTAssertTrue(r.contains([3, 2, 1]))
        }
    }
    
    func testPermutatinsPerformance() {
        measure {
            let r = permutations(of: Array(1 ... 8))
            XCTAssertEqual(r.count, 40320)
        }
    }
}
