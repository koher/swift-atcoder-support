import XCTest
@testable import AtCoderSupport

final class BinarySearchTests: XCTestCase {
    func testValuesLT() {
        do {
            let a = [0, 1, 1, 2, 3, 5, 8]
            do {
                let r = a.values(<, -1)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<, 0)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<, 1)
                XCTAssertEqual(r, [0])
            }
            do {
                let r = a.values(<, 2)
                XCTAssertEqual(r, [0, 1, 1])
            }
            do {
                let r = a.values(<, 3)
                XCTAssertEqual(r, [0, 1, 1, 2])
            }
            do {
                let r = a.values(<, 4)
                XCTAssertEqual(r, [0, 1, 1, 2, 3])
            }
            do {
                let r = a.values(<, 5)
                XCTAssertEqual(r, [0, 1, 1, 2, 3])
            }
            do {
                let r = a.values(<, 6)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<, 7)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<, 8)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<, 9)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(<, 10)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
        }
        
        do { // Collections but `Array`s
            let a: ArraySlice<Int> = [0, 1, 1, 2, 3, 5, 8, 13][1 ..< 7]
            do {
                let r = a.values(<, -1)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<, 0)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<, 1)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<, 2)
                XCTAssertEqual(r, [1, 1])
            }
            do {
                let r = a.values(<, 3)
                XCTAssertEqual(r, [1, 1, 2])
            }
            do {
                let r = a.values(<, 4)
                XCTAssertEqual(r, [1, 1, 2, 3])
            }
            do {
                let r = a.values(<, 5)
                XCTAssertEqual(r, [1, 1, 2, 3])
            }
            do {
                let r = a.values(<, 6)
                XCTAssertEqual(r, [1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<, 7)
                XCTAssertEqual(r, [1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<, 8)
                XCTAssertEqual(r, [1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<, 9)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(<, 10)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
        }
        do { // Overflow of `low + high`
            let a =  (Int.max - 10) ..< Int.max
            let r = a.values(<, Int.max - 3)
            XCTAssertEqual(r.count, 7)
        }
    }
    
    func testValuesLE() {
        do {
            let a = [0, 1, 1, 2, 3, 5, 8]
            do {
                let r = a.values(<=, -2)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<=, -1)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<=, 0)
                XCTAssertEqual(r, [0])
            }
            do {
                let r = a.values(<=, 1)
                XCTAssertEqual(r, [0, 1, 1])
            }
            do {
                let r = a.values(<=, 2)
                XCTAssertEqual(r, [0, 1, 1, 2])
            }
            do {
                let r = a.values(<=, 3)
                XCTAssertEqual(r, [0, 1, 1, 2, 3])
            }
            do {
                let r = a.values(<=, 4)
                XCTAssertEqual(r, [0, 1, 1, 2, 3])
            }
            do {
                let r = a.values(<=, 5)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<=, 6)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<=, 7)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<=, 8)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(<=, 9)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(<=, 10)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
        }
        do { // Collections but `Array`s
            let a: ArraySlice<Int> = [0, 1, 1, 2, 3, 5, 8, 13][1 ..< 7]
            do {
                let r = a.values(<=, -2)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<=, -1)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<=, 0)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(<=, 1)
                XCTAssertEqual(r, [1, 1])
            }
            do {
                let r = a.values(<=, 2)
                XCTAssertEqual(r, [1, 1, 2])
            }
            do {
                let r = a.values(<=, 3)
                XCTAssertEqual(r, [1, 1, 2, 3])
            }
            do {
                let r = a.values(<=, 4)
                XCTAssertEqual(r, [1, 1, 2, 3])
            }
            do {
                let r = a.values(<=, 5)
                XCTAssertEqual(r, [1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<=, 6)
                XCTAssertEqual(r, [1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<=, 7)
                XCTAssertEqual(r, [1, 1, 2, 3, 5])
            }
            do {
                let r = a.values(<=, 8)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(<=, 9)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(<=, 10)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
        }
        do { // Overflow of `low + high`
            let a =  (Int.max - 10) ..< Int.max
            let r = a.values(<=, Int.max - 3)
            XCTAssertEqual(r.count, 8)
        }
    }
    
    func testValuesGT() {
        do {
            let a = [0, 1, 1, 2, 3, 5, 8]
            do {
                let r = a.values(>, -2)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>, -1)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>, 0)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>, 1)
                XCTAssertEqual(r, [2, 3, 5, 8])
            }
            do {
                let r = a.values(>, 2)
                XCTAssertEqual(r, [3, 5, 8])
            }
            do {
                let r = a.values(>, 3)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>, 4)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>, 5)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>, 6)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>, 7)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>, 8)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(>, 9)
                XCTAssertEqual(r, [])
            }
        }
        
        do { // Collections but `Array`s
            let a: ArraySlice<Int> = [0, 1, 1, 2, 3, 5, 8, 13][1 ..< 7]
            do {
                let r = a.values(>, -1)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>, 0)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>, 1)
                XCTAssertEqual(r, [2, 3, 5, 8])
            }
            do {
                let r = a.values(>, 2)
                XCTAssertEqual(r, [3, 5, 8])
            }
            do {
                let r = a.values(>, 3)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>, 4)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>, 5)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>, 6)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>, 7)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>, 8)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(>, 9)
                XCTAssertEqual(r, [])
            }
        }
        do { // Overflow of `low + high`
            let a =  (Int.max - 10) ..< Int.max
            let r = a.values(>, Int.max - 3)
            XCTAssertEqual(r.count, 2)
        }
    }
    
    func testValuesGE() {
        do {
            let a = [0, 1, 1, 2, 3, 5, 8]
            do {
                let r = a.values(>=, -2)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, -1)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 0)
                XCTAssertEqual(r, [0, 1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 1)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 2)
                XCTAssertEqual(r, [2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 3)
                XCTAssertEqual(r, [3, 5, 8])
            }
            do {
                let r = a.values(>=, 4)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>=, 5)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>=, 6)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>=, 7)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>=, 8)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>=, 9)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(>=, 10)
                XCTAssertEqual(r, [])
            }
        }
        do { // Collections but `Array`s
            let a: ArraySlice<Int> = [0, 1, 1, 2, 3, 5, 8, 13][1 ..< 7]
            do {
                let r = a.values(>=, -1)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 0)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 1)
                XCTAssertEqual(r, [1, 1, 2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 2)
                XCTAssertEqual(r, [2, 3, 5, 8])
            }
            do {
                let r = a.values(>=, 3)
                XCTAssertEqual(r, [3, 5, 8])
            }
            do {
                let r = a.values(>=, 4)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>=, 5)
                XCTAssertEqual(r, [5, 8])
            }
            do {
                let r = a.values(>=, 6)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>=, 7)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>=, 8)
                XCTAssertEqual(r, [8])
            }
            do {
                let r = a.values(>=, 9)
                XCTAssertEqual(r, [])
            }
            do {
                let r = a.values(>=, 10)
                XCTAssertEqual(r, [])
            }
        }
        do { // Overflow of `low + high`
            let a =  (Int.max - 10) ..< Int.max
            let r = a.values(>=, Int.max - 3)
            XCTAssertEqual(r.count, 3)
        }
    }
    
    #if !DEBUG
    func testValuesLTPerformance() {
        let a = 0 ..< 10_000_000_000_000
        measure {
            let r = a.values(<, 9_000_000_000_000)
            XCTAssertEqual(r.count, 9_000_000_000_000)
        }
    }
    
    func testValuesLEPerformance() {
        let a = 0 ..< 10_000_000_000_000
        measure {
            let r = a.values(<=, 9_000_000_000_000)
            XCTAssertEqual(r.count, 9_000_000_000_001)
        }
    }
    
    func testValuesGTPerformance() {
        let a = 0 ..< 10_000_000_000_000
        measure {
            let r = a.values(>, 9_000_000_000_000)
            XCTAssertEqual(r.count, 999_999_999_999)
        }
    }
    
    func testValuesGEPerformance() {
        let a = 0 ..< 10_000_000_000_000
        measure {
            let r = a.values(>=, 9_000_000_000_000)
            XCTAssertEqual(r.count, 1_000_000_000_000)
        }
    }
    #endif
}
