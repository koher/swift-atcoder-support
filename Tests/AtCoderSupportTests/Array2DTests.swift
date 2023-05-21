import XCTest
@testable import AtCoderSupport

final class Array2DTests: XCTestCase {
    func testInit() {
        do {
            let a: Array2D<Int> = .init(width: 3, height: 2, element: 42)
            
            XCTAssertEqual(a[0, 0], 42)
            XCTAssertEqual(a[0, 1], 42)
            XCTAssertEqual(a[0, 2], 42)

            XCTAssertEqual(a[1, 0], 42)
            XCTAssertEqual(a[1, 1], 42)
            XCTAssertEqual(a[1, 2], 42)
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
            XCTAssertEqual(a[0, 1], 2)
            XCTAssertEqual(a[0, 2], 3)
            XCTAssertEqual(a[0, 3], 4)
            
            XCTAssertEqual(a[1, 0], 5)
            XCTAssertEqual(a[1, 1], 6)
            XCTAssertEqual(a[1, 2], 7)
            XCTAssertEqual(a[1, 3], 8)
            
            XCTAssertEqual(a[2, 0], 9)
            XCTAssertEqual(a[2, 1], 10)
            XCTAssertEqual(a[2, 2], 11)
            XCTAssertEqual(a[2, 3], 12)
        }
        do {
            let a: Array2D<Int> = .init(width: 4, height: 3, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
            ], outside: -1)
            
            XCTAssertEqual(a[0, 0], 1)
            XCTAssertEqual(a[0, 1], 2)
            XCTAssertEqual(a[0, 2], 3)
            XCTAssertEqual(a[0, 3], 4)
            
            XCTAssertEqual(a[1, 0], 5)
            XCTAssertEqual(a[1, 1], 6)
            XCTAssertEqual(a[1, 2], 7)
            XCTAssertEqual(a[1, 3], 8)
            
            XCTAssertEqual(a[2, 0], 9)
            XCTAssertEqual(a[2, 1], 10)
            XCTAssertEqual(a[2, 2], 11)
            XCTAssertEqual(a[2, 3], 12)
            
            XCTAssertEqual(a[-1, -1], -1)
            XCTAssertEqual(a[-1, 4], -1)
            XCTAssertEqual(a[3, -1], -1)
            XCTAssertEqual(a[3, 4], -1)
            
            XCTAssertEqual(a[0, -1], -1)
            XCTAssertEqual(a[-1, 0], -1)
            XCTAssertEqual(a[0, 4], -1)
            XCTAssertEqual(a[3, 0], -1)
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
            a[0, 1] = 200
            a[0, 2] = 300
            a[0, 3] = 400
            
            a[1, 0] = 500
            a[1, 1] = 600
            a[1, 2] = 700
            a[1, 3] = 800
            
            a[2, 0] = 900
            a[2, 1] = 1000
            a[2, 2] = 1100
            a[2, 3] = 1200
            
            a[-1, -1] = -100
            a[-1, 4] = -100
            a[3, -1] = -100
            a[3, 4] = -100

            a[0, -1] = -123
            a[-1, 0] = -234
            a[0, 4] = -345
            a[3, 0] = -456

            XCTAssertEqual(a[0, 0], 100)
            XCTAssertEqual(a[0, 1], 200)
            XCTAssertEqual(a[0, 2], 300)
            XCTAssertEqual(a[0, 3], 400)
            
            XCTAssertEqual(a[1, 0], 500)
            XCTAssertEqual(a[1, 1], 600)
            XCTAssertEqual(a[1, 2], 700)
            XCTAssertEqual(a[1, 3], 800)
            
            XCTAssertEqual(a[2, 0], 900)
            XCTAssertEqual(a[2, 1], 1000)
            XCTAssertEqual(a[2, 2], 1100)
            XCTAssertEqual(a[2, 3], 1200)
            
            XCTAssertEqual(a[-1, -1], -1)
            XCTAssertEqual(a[-1, 4], -1)
            XCTAssertEqual(a[3, -1], -1)
            XCTAssertEqual(a[3, 4], -1)
            
            XCTAssertEqual(a[0, -1], -1)
            XCTAssertEqual(a[-1, 0], -1)
            XCTAssertEqual(a[0, 4], -1)
            XCTAssertEqual(a[3, 0], -1)
        }
    }
}
