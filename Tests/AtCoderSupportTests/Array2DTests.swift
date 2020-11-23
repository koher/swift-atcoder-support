import XCTest
@testable import AtCoderSupport

final class Array2DTests: XCTestCase {
    func testInit() {
        do {
            let a: Array2D<Int> = .init(width: 3, height: 2, element: 42)
            
            XCTAssertEqual(a[0, 0], 42)
            XCTAssertEqual(a[1, 0], 42)
            XCTAssertEqual(a[2, 0], 42)

            XCTAssertEqual(a[0, 1], 42)
            XCTAssertEqual(a[1, 1], 42)
            XCTAssertEqual(a[2, 1], 42)
        }
    }
    
    func testCount() {
        do {
            let a: Array2D<Int> = .init(width: 4, height: 3, element: 42)
            let r = a.count
            XCTAssertEqual(r, 12)
        }
    }
    
    func testSubscriptGet() {
        do {
            let a: Array2D<Int> = .init(width: 4, height: 3, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
            ])
            
            XCTAssertEqual(a[0, 0], 1)
            XCTAssertEqual(a[1, 0], 2)
            XCTAssertEqual(a[2, 0], 3)
            XCTAssertEqual(a[3, 0], 4)
            
            XCTAssertEqual(a[0, 1], 5)
            XCTAssertEqual(a[1, 1], 6)
            XCTAssertEqual(a[2, 1], 7)
            XCTAssertEqual(a[3, 1], 8)
            
            XCTAssertEqual(a[0, 2], 9)
            XCTAssertEqual(a[1, 2], 10)
            XCTAssertEqual(a[2, 2], 11)
            XCTAssertEqual(a[3, 2], 12)
        }
        do {
            let a: Array2D<Int> = .init(width: 4, height: 3, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
            ], outside: -1)
            
            XCTAssertEqual(a[0, 0], 1)
            XCTAssertEqual(a[1, 0], 2)
            XCTAssertEqual(a[2, 0], 3)
            XCTAssertEqual(a[3, 0], 4)
            
            XCTAssertEqual(a[0, 1], 5)
            XCTAssertEqual(a[1, 1], 6)
            XCTAssertEqual(a[2, 1], 7)
            XCTAssertEqual(a[3, 1], 8)
            
            XCTAssertEqual(a[0, 2], 9)
            XCTAssertEqual(a[1, 2], 10)
            XCTAssertEqual(a[2, 2], 11)
            XCTAssertEqual(a[3, 2], 12)
            
            XCTAssertEqual(a[-1, -1], -1)
            XCTAssertEqual(a[4, -1], -1)
            XCTAssertEqual(a[-1, 3], -1)
            XCTAssertEqual(a[4, 3], -1)
            
            XCTAssertEqual(a[-1, 0], -1)
            XCTAssertEqual(a[0, -1], -1)
            XCTAssertEqual(a[4, 0], -1)
            XCTAssertEqual(a[0, 3], -1)
        }
    }
    
    func testSubscriptSet() {
        do {
            var a: Array2D<Int> = .init(width: 4, height: 3, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
            ], outside: -1)
            
            a[0, 0] = 100
            a[1, 0] = 200
            a[2, 0] = 300
            a[3, 0] = 400
            
            a[0, 1] = 500
            a[1, 1] = 600
            a[2, 1] = 700
            a[3, 1] = 800
            
            a[0, 2] = 900
            a[1, 2] = 1000
            a[2, 2] = 1100
            a[3, 2] = 1200
            
            a[-1, -1] = -100
            a[4, -1] = -100
            a[-1, 3] = -100
            a[4, 3] = -100

            a[-1, 0] = -100
            a[0, -1] = -100
            a[4, 0] = -100
            a[0, 3] = -100

            XCTAssertEqual(a[0, 0], 100)
            XCTAssertEqual(a[1, 0], 200)
            XCTAssertEqual(a[2, 0], 300)
            XCTAssertEqual(a[3, 0], 400)
            
            XCTAssertEqual(a[0, 1], 500)
            XCTAssertEqual(a[1, 1], 600)
            XCTAssertEqual(a[2, 1], 700)
            XCTAssertEqual(a[3, 1], 800)
            
            XCTAssertEqual(a[0, 2], 900)
            XCTAssertEqual(a[1, 2], 1000)
            XCTAssertEqual(a[2, 2], 1100)
            XCTAssertEqual(a[3, 2], 1200)
            
            XCTAssertEqual(a[-1, -1], -1)
            XCTAssertEqual(a[4, -1], -1)
            XCTAssertEqual(a[-1, 3], -1)
            XCTAssertEqual(a[4, 3], -1)
            
            XCTAssertEqual(a[-1, 0], -1)
            XCTAssertEqual(a[0, -1], -1)
            XCTAssertEqual(a[4, 0], -1)
            XCTAssertEqual(a[0, 3], -1)
        }
    }
}
