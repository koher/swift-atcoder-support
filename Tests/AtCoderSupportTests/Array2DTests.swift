import XCTest
@testable import AtCoderSupport

final class Array2DTests: XCTestCase {
    func testInit() {
        do {
            let a: Array2D<Int> = .init(height: 2, width: 3, element: 42)
            
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
            let a: Array2D<Int> = .init(height: 3, width: 4, element: 42)
            let r = a.count
            XCTAssertEqual(r, 12)
        }
    }
    
    func testSubscriptGet() {
        do {
            let a: Array2D<Int> = .init(height: 3, width: 4, elements: [
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
            let a: Array2D<Int> = .init(height: 3, width: 4, elements: [
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
            var a: Array2D<Int> = .init(height: 3, width: 4, elements: [
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

    func testNeighbourCoord() {
        let target = [
            "0*0", "0*1", "0*2", "0*3",
            "1*0", "1*1", "1*2", "1*3",
            "2*0", "2*1", "2*2", "2*3",
            "3*0", "3*1", "3*2", "3*3",
            "4*0", "4*1", "4*2", "4*3"
        ]
        let a: Array2D<String> = .init(height: 5, width: 4, elements: target)
        do {
            let neighbourList = a.neighboursCoord4(around: (1, 1))
            let expectedList = [(1, 2), (0, 1), (1, 0), (2, 1)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let neighbourList = a.neighboursCoord4(around: (0, 1))
            let expectedList = [(0, 2), (0, 0), (1, 1)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let neighbourList = a.neighboursCoord4(around: (0, 0))
            let expectedList = [(0, 1), (1, 0)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let neighbourList = a.neighboursCoord4(around: (0, 0), ignoreOutside: false)
            let expectedList = [(0, 1), (-1, 0), (0, -1), (1, 0)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
    }

    func testSeekWords() {
        let strs = [
            "asdfghjk",
            "zxcvbnez",
            "qwerykio",
            "asdfuyui",
            "qwenhjkl",
            "qwscvbfu",
            "nbvcytfr"
        ]
        let a: Array2D<Character> = .init(height: strs.count, width: strs[0].count, stringArray: strs)
        let result = a.seek(word: "snuke")
        XCTAssertNotNil(result)
        let expected = [(5, 2), (4, 3), (3, 4), (2, 5), (1, 6)]
        for (i, (r, c)) in result!.enumerated() {
            XCTAssertEqual(r, expected[i].0)
            XCTAssertEqual(c, expected[i].1)
        }
    }
}
