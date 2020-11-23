import XCTest
@testable import AtCoderSupport

final class Array3DTests: XCTestCase {
    func testInit() {
        do {
            let a: Array3D<Int> = .init(width: 4, height: 3, depth: 2, element: 42)
            
            XCTAssertEqual(a[0, 0, 0], 42)
            XCTAssertEqual(a[1, 0, 0], 42)
            XCTAssertEqual(a[2, 0, 0], 42)
            XCTAssertEqual(a[3, 0, 0], 42)

            XCTAssertEqual(a[0, 1, 0], 42)
            XCTAssertEqual(a[1, 1, 0], 42)
            XCTAssertEqual(a[2, 1, 0], 42)
            XCTAssertEqual(a[3, 1, 0], 42)
            
            XCTAssertEqual(a[0, 2, 0], 42)
            XCTAssertEqual(a[1, 2, 0], 42)
            XCTAssertEqual(a[2, 2, 0], 42)
            XCTAssertEqual(a[3, 2, 0], 42)
            
            XCTAssertEqual(a[0, 0, 1], 42)
            XCTAssertEqual(a[1, 0, 1], 42)
            XCTAssertEqual(a[2, 0, 1], 42)
            XCTAssertEqual(a[3, 0, 1], 42)
            
            XCTAssertEqual(a[0, 1, 1], 42)
            XCTAssertEqual(a[1, 1, 1], 42)
            XCTAssertEqual(a[2, 1, 1], 42)
            XCTAssertEqual(a[3, 1, 1], 42)
            
            XCTAssertEqual(a[0, 2, 1], 42)
            XCTAssertEqual(a[1, 2, 1], 42)
            XCTAssertEqual(a[2, 2, 1], 42)
            XCTAssertEqual(a[3, 2, 1], 42)
        }
    }
    
    func testCount() {
        do {
            let a: Array3D<Int> = .init(width: 5, height: 4, depth: 3, element: 42)
            let r = a.count
            XCTAssertEqual(r, 60)
        }
    }
    
    func testSubscriptGet() {
        do {
            let a: Array3D<Int> = .init(width: 4, height: 3, depth: 2, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
                
                13, 14, 15, 16,
                17, 18, 19, 20,
                21, 22, 23, 24,
            ])
            
            XCTAssertEqual(a[0, 0, 0], 1)
            XCTAssertEqual(a[1, 0, 0], 2)
            XCTAssertEqual(a[2, 0, 0], 3)
            XCTAssertEqual(a[3, 0, 0], 4)

            XCTAssertEqual(a[0, 1, 0], 5)
            XCTAssertEqual(a[1, 1, 0], 6)
            XCTAssertEqual(a[2, 1, 0], 7)
            XCTAssertEqual(a[3, 1, 0], 8)
            
            XCTAssertEqual(a[0, 2, 0], 9)
            XCTAssertEqual(a[1, 2, 0], 10)
            XCTAssertEqual(a[2, 2, 0], 11)
            XCTAssertEqual(a[3, 2, 0], 12)
            
            XCTAssertEqual(a[0, 0, 1], 13)
            XCTAssertEqual(a[1, 0, 1], 14)
            XCTAssertEqual(a[2, 0, 1], 15)
            XCTAssertEqual(a[3, 0, 1], 16)

            XCTAssertEqual(a[0, 1, 1], 17)
            XCTAssertEqual(a[1, 1, 1], 18)
            XCTAssertEqual(a[2, 1, 1], 19)
            XCTAssertEqual(a[3, 1, 1], 20)
            
            XCTAssertEqual(a[0, 2, 1], 21)
            XCTAssertEqual(a[1, 2, 1], 22)
            XCTAssertEqual(a[2, 2, 1], 23)
            XCTAssertEqual(a[3, 2, 1], 24)
        }
        do {
            let a: Array3D<Int> = .init(width: 4, height: 3, depth: 2, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
                
                13, 14, 15, 16,
                17, 18, 19, 20,
                21, 22, 23, 24,
            ], outside: -1)
            
            XCTAssertEqual(a[0, 0, 0], 1)
            XCTAssertEqual(a[1, 0, 0], 2)
            XCTAssertEqual(a[2, 0, 0], 3)
            XCTAssertEqual(a[3, 0, 0], 4)

            XCTAssertEqual(a[0, 1, 0], 5)
            XCTAssertEqual(a[1, 1, 0], 6)
            XCTAssertEqual(a[2, 1, 0], 7)
            XCTAssertEqual(a[3, 1, 0], 8)
            
            XCTAssertEqual(a[0, 2, 0], 9)
            XCTAssertEqual(a[1, 2, 0], 10)
            XCTAssertEqual(a[2, 2, 0], 11)
            XCTAssertEqual(a[3, 2, 0], 12)
            
            XCTAssertEqual(a[0, 0, 1], 13)
            XCTAssertEqual(a[1, 0, 1], 14)
            XCTAssertEqual(a[2, 0, 1], 15)
            XCTAssertEqual(a[3, 0, 1], 16)

            XCTAssertEqual(a[0, 1, 1], 17)
            XCTAssertEqual(a[1, 1, 1], 18)
            XCTAssertEqual(a[2, 1, 1], 19)
            XCTAssertEqual(a[3, 1, 1], 20)
            
            XCTAssertEqual(a[0, 2, 1], 21)
            XCTAssertEqual(a[1, 2, 1], 22)
            XCTAssertEqual(a[2, 2, 1], 23)
            XCTAssertEqual(a[3, 2, 1], 24)
            
            XCTAssertEqual(a[-1, -1, -1], -1)
            XCTAssertEqual(a[4, -1, -1], -1)
            XCTAssertEqual(a[-1, 3, -1], -1)
            XCTAssertEqual(a[4, 3, -1], -1)
            XCTAssertEqual(a[-1, -1, 2], -1)
            XCTAssertEqual(a[4, -1, 2], -1)
            XCTAssertEqual(a[-1, 3, 2], -1)
            XCTAssertEqual(a[4, 3, 2], -1)
            
            XCTAssertEqual(a[-1, 0, 0], -1)
            XCTAssertEqual(a[0, -1, 0], -1)
            XCTAssertEqual(a[0, 0, -1], -1)
            XCTAssertEqual(a[4, 0, 0], -1)
            XCTAssertEqual(a[0, 3, 0], -1)
            XCTAssertEqual(a[0, 0, 2], -1)
        }
    }
    
    func testSubscriptSet() {
        do {
            var a: Array3D<Int> = .init(width: 4, height: 3, depth: 2, elements: [
                1, 2, 3, 4,
                5, 6, 7, 8,
                9, 10, 11, 12,
                
                13, 14, 15, 16,
                17, 18, 19, 20,
                21, 22, 23, 24,
            ], outside: -1)

            a[0, 0, 0] = 100
            a[1, 0, 0] = 200
            a[2, 0, 0] = 300
            a[3, 0, 0] = 400
            
            a[0, 1, 0] = 500
            a[1, 1, 0] = 600
            a[2, 1, 0] = 700
            a[3, 1, 0] = 800
            
            a[0, 2, 0] = 900
            a[1, 2, 0] = 1000
            a[2, 2, 0] = 1100
            a[3, 2, 0] = 1200
            
            a[0, 0, 1] = 1300
            a[1, 0, 1] = 1400
            a[2, 0, 1] = 1500
            a[3, 0, 1] = 1600
            
            a[0, 1, 1] = 1700
            a[1, 1, 1] = 1800
            a[2, 1, 1] = 1900
            a[3, 1, 1] = 2000
            
            a[0, 2, 1] = 2100
            a[1, 2, 1] = 2200
            a[2, 2, 1] = 2300
            a[3, 2, 1] = 2400
            
            a[-1, -1, -1] = -100
            a[4, -1, -1] = -100
            a[-1, 3, -1] = -100
            a[4, 3, -1] = -100
            a[-1, -1, 2] = -100
            a[4, -1, 2] = -100
            a[-1, 3, 2] = -100
            a[4, 3, 2] = -100
            
            a[-1, 0, 0] = -100
            a[0, -1, 0] = -100
            a[0, 0, -1] = -100
            a[4, 0, 0] = -100
            a[0, 3, 0] = -100
            a[0, 0, 2] = -100

            XCTAssertEqual(a[0, 0, 0], 100)
            XCTAssertEqual(a[1, 0, 0], 200)
            XCTAssertEqual(a[2, 0, 0], 300)
            XCTAssertEqual(a[3, 0, 0], 400)
            
            XCTAssertEqual(a[0, 1, 0], 500)
            XCTAssertEqual(a[1, 1, 0], 600)
            XCTAssertEqual(a[2, 1, 0], 700)
            XCTAssertEqual(a[3, 1, 0], 800)
            
            XCTAssertEqual(a[0, 2, 0], 900)
            XCTAssertEqual(a[1, 2, 0], 1000)
            XCTAssertEqual(a[2, 2, 0], 1100)
            XCTAssertEqual(a[3, 2, 0], 1200)
            
            XCTAssertEqual(a[0, 0, 1], 1300)
            XCTAssertEqual(a[1, 0, 1], 1400)
            XCTAssertEqual(a[2, 0, 1], 1500)
            XCTAssertEqual(a[3, 0, 1], 1600)
            
            XCTAssertEqual(a[0, 1, 1], 1700)
            XCTAssertEqual(a[1, 1, 1], 1800)
            XCTAssertEqual(a[2, 1, 1], 1900)
            XCTAssertEqual(a[3, 1, 1], 2000)
            
            XCTAssertEqual(a[0, 2, 1], 2100)
            XCTAssertEqual(a[1, 2, 1], 2200)
            XCTAssertEqual(a[2, 2, 1], 2300)
            XCTAssertEqual(a[3, 2, 1], 2400)
            
            XCTAssertEqual(a[-1, -1, -1], -1)
            XCTAssertEqual(a[4, -1, -1], -1)
            XCTAssertEqual(a[-1, 3, -1], -1)
            XCTAssertEqual(a[4, 3, -1], -1)
            XCTAssertEqual(a[-1, -1, 2], -1)
            XCTAssertEqual(a[4, -1, 2], -1)
            XCTAssertEqual(a[-1, 3, 2], -1)
            XCTAssertEqual(a[4, 3, 2], -1)
            
            XCTAssertEqual(a[-1, 0, 0], -1)
            XCTAssertEqual(a[0, -1, 0], -1)
            XCTAssertEqual(a[0, 0, -1], -1)
            XCTAssertEqual(a[4, 0, 0], -1)
            XCTAssertEqual(a[0, 3, 0], -1)
            XCTAssertEqual(a[0, 0, 2], -1)
        }
    }
}
