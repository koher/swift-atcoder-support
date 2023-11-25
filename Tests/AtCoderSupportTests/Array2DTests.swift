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
            let neighbourList = a.neighbours(around: (1, 1))
            let expectedList = [(1, 2), (0, 1), (1, 0), (2, 1)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let neighbourList = a.neighbours(around: (0, 1))
            let expectedList = [(0, 2), (0, 0), (1, 1)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let neighbourList = a.neighbours(around: (0, 0))
            let expectedList = [(0, 1), (1, 0)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let neighbourList = a.neighbours(around: (0, 0), ignoreOutside: false)
            let expectedList = [(0, 1), (-1, 0), (0, -1), (1, 0)]
            for (i, (r, c)) in neighbourList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
    }

    func testSurroundimgsCoord() {
        let target = [
            "0*0", "0*1", "0*2", "0*3",
            "1*0", "1*1", "1*2", "1*3",
            "2*0", "2*1", "2*2", "2*3",
            "3*0", "3*1", "3*2", "3*3",
            "4*0", "4*1", "4*2", "4*3"
        ]
        let a: Array2D<String> = .init(height: 5, width: 4, elements: target)
        do {
            let surroundList = a.surroundings(around: (1, 1))
            let expectedList = [(1, 2), (0, 2), (0, 1), (0, 0), (1, 0), (2, 0), (2, 1), (2, 2)]
            for (i, (r, c)) in surroundList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let surroundList = a.surroundings(around: (0, 1))
            let expectedList = [(0, 2), (0, 0), (1, 0), (1, 1), (1, 2)]
            for (i, (r, c)) in surroundList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let surroundList = a.surroundings(around: (0, 0))
            let expectedList = [(0, 1), (1, 0), (1, 1)]
            for (i, (r, c)) in surroundList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
        do {
            let surroundList = a.surroundings(around: (0, 0), ignoreOutside: false)
            let expectedList = [(0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1), (1, 0), (1, 1)]
            for (i, (r, c)) in surroundList.enumerated() {
                XCTAssertEqual(r, expectedList[i].0)
                XCTAssertEqual(c, expectedList[i].1)
            }
        }
    }

    func testLocationList() {
        let strs = [
            "........",
            "..*.....",
            "........",
            ".*......",
            ".....*..",
            "........"
        ]
        let a: Array2D<Character> = .init(height: strs.count, width: strs[0].count, stringArray: strs)
        do {
            let list = a.locationList(condition: { $0 == "*" })
            XCTAssertTrue(list.contains { row, col in row == 1 && col == 2 })
            XCTAssertTrue(list.contains { row, col in row == 3 && col == 1 })
            XCTAssertTrue(list.contains { row, col in row == 4 && col == 5 })
        }
        do {
            let list = a.locationList(condition: { $0 == "X" })
            XCTAssertTrue(list.isEmpty)
        }
    }

    func testRotatedSize() {
        let target = [Bool](repeating: false, count: 28)
        var a: Array2D<Bool> = .init(height: 7, width: 4, elements: target)
        XCTAssertEqual(a.width, 4)
        a.rotate()
        XCTAssertEqual(a.width, 7)
        a.rotate()
        XCTAssertEqual(a.width, 4)
    }

    func testRotateOnce() {
        let target = [
            "0_0", "0_1", "0_2", "0_3",
            "1_0", "1_1", "1_2", "1_3",
            "2_0", "2_1", "2_2", "2_3",
            "3_0", "3_1", "3_2", "3_3",
            "4_0", "4_1", "4_2", "4_3",
            "5_0", "5_1", "5_2", "5_3",
            "6_0", "6_1", "6_2", "6_3"
        ]
        var a: Array2D<String> = .init(height: 7, width: 4, elements: target)
        a.rotate()

        XCTAssertEqual(a[0, 0], "6_0")
        XCTAssertEqual(a[0, 1], "5_0")
        XCTAssertEqual(a[0, 2], "4_0")
        XCTAssertEqual(a[0, 3], "3_0")
        XCTAssertEqual(a[0, 4], "2_0")
        XCTAssertEqual(a[0, 5], "1_0")
        XCTAssertEqual(a[0, 6], "0_0")

        XCTAssertEqual(a[1, 0], "6_1")
        XCTAssertEqual(a[1, 1], "5_1")
        XCTAssertEqual(a[1, 2], "4_1")
        XCTAssertEqual(a[1, 3], "3_1")
        XCTAssertEqual(a[1, 4], "2_1")
        XCTAssertEqual(a[1, 5], "1_1")
        XCTAssertEqual(a[1, 6], "0_1")

        XCTAssertEqual(a[2, 0], "6_2")
        XCTAssertEqual(a[2, 1], "5_2")
        XCTAssertEqual(a[2, 2], "4_2")
        XCTAssertEqual(a[2, 3], "3_2")
        XCTAssertEqual(a[2, 4], "2_2")
        XCTAssertEqual(a[2, 5], "1_2")
        XCTAssertEqual(a[2, 6], "0_2")

        XCTAssertEqual(a[3, 0], "6_3")
        XCTAssertEqual(a[3, 1], "5_3")
        XCTAssertEqual(a[3, 2], "4_3")
        XCTAssertEqual(a[3, 3], "3_3")
        XCTAssertEqual(a[3, 4], "2_3")
        XCTAssertEqual(a[3, 5], "1_3")
        XCTAssertEqual(a[3, 6], "0_3")
    }

    func testRotateTwice() {
        let target = [
            "0_0", "0_1", "0_2", "0_3",
            "1_0", "1_1", "1_2", "1_3",
            "2_0", "2_1", "2_2", "2_3",
            "3_0", "3_1", "3_2", "3_3",
            "4_0", "4_1", "4_2", "4_3",
            "5_0", "5_1", "5_2", "5_3",
            "6_0", "6_1", "6_2", "6_3"
        ]
        var a: Array2D<String> = .init(height: 7, width: 4, elements: target)
        a.rotate(count: 2)

        XCTAssertEqual(a[0, 0], "6_3")
        XCTAssertEqual(a[0, 1], "6_2")
        XCTAssertEqual(a[0, 2], "6_1")
        XCTAssertEqual(a[0, 3], "6_0")

        XCTAssertEqual(a[1, 0], "5_3")
        XCTAssertEqual(a[1, 1], "5_2")
        XCTAssertEqual(a[1, 2], "5_1")
        XCTAssertEqual(a[1, 3], "5_0")

        XCTAssertEqual(a[2, 0], "4_3")
        XCTAssertEqual(a[2, 1], "4_2")
        XCTAssertEqual(a[2, 2], "4_1")
        XCTAssertEqual(a[2, 3], "4_0")

        XCTAssertEqual(a[3, 0], "3_3")
        XCTAssertEqual(a[3, 1], "3_2")
        XCTAssertEqual(a[3, 2], "3_1")
        XCTAssertEqual(a[3, 3], "3_0")

        XCTAssertEqual(a[4, 0], "2_3")
        XCTAssertEqual(a[4, 1], "2_2")
        XCTAssertEqual(a[4, 2], "2_1")
        XCTAssertEqual(a[4, 3], "2_0")

        XCTAssertEqual(a[5, 0], "1_3")
        XCTAssertEqual(a[5, 1], "1_2")
        XCTAssertEqual(a[5, 2], "1_1")
        XCTAssertEqual(a[5, 3], "1_0")

        XCTAssertEqual(a[6, 0], "0_3")
        XCTAssertEqual(a[6, 1], "0_2")
        XCTAssertEqual(a[6, 2], "0_1")
        XCTAssertEqual(a[6, 3], "0_0")
    }

    func testRotateThreeTimes() {
        let target = [
            "0_0", "0_1", "0_2", "0_3",
            "1_0", "1_1", "1_2", "1_3",
            "2_0", "2_1", "2_2", "2_3",
            "3_0", "3_1", "3_2", "3_3",
            "4_0", "4_1", "4_2", "4_3",
            "5_0", "5_1", "5_2", "5_3",
            "6_0", "6_1", "6_2", "6_3"
        ]
        var a: Array2D<String> = .init(height: 7, width: 4, elements: target)
        a.rotate(count: 3)

        XCTAssertEqual(a[0, 0], "0_3")
        XCTAssertEqual(a[0, 1], "1_3")
        XCTAssertEqual(a[0, 2], "2_3")
        XCTAssertEqual(a[0, 3], "3_3")
        XCTAssertEqual(a[0, 4], "4_3")
        XCTAssertEqual(a[0, 5], "5_3")
        XCTAssertEqual(a[0, 6], "6_3")

        XCTAssertEqual(a[1, 0], "0_2")
        XCTAssertEqual(a[1, 1], "1_2")
        XCTAssertEqual(a[1, 2], "2_2")
        XCTAssertEqual(a[1, 3], "3_2")
        XCTAssertEqual(a[1, 4], "4_2")
        XCTAssertEqual(a[1, 5], "5_2")
        XCTAssertEqual(a[1, 6], "6_2")

        XCTAssertEqual(a[2, 0], "0_1")
        XCTAssertEqual(a[2, 1], "1_1")
        XCTAssertEqual(a[2, 2], "2_1")
        XCTAssertEqual(a[2, 3], "3_1")
        XCTAssertEqual(a[2, 4], "4_1")
        XCTAssertEqual(a[2, 5], "5_1")
        XCTAssertEqual(a[2, 6], "6_1")

        XCTAssertEqual(a[3, 0], "0_0")
        XCTAssertEqual(a[3, 1], "1_0")
        XCTAssertEqual(a[3, 2], "2_0")
        XCTAssertEqual(a[3, 3], "3_0")
        XCTAssertEqual(a[3, 4], "4_0")
        XCTAssertEqual(a[3, 5], "5_0")
        XCTAssertEqual(a[3, 6], "6_0")
    }

    func testRotateFourTimes() {
        let target = [
            "0_0", "0_1", "0_2", "0_3",
            "1_0", "1_1", "1_2", "1_3",
            "2_0", "2_1", "2_2", "2_3",
            "3_0", "3_1", "3_2", "3_3",
            "4_0", "4_1", "4_2", "4_3",
            "5_0", "5_1", "5_2", "5_3",
            "6_0", "6_1", "6_2", "6_3"
        ]
        var a: Array2D<String> = .init(height: 7, width: 4, elements: target)
        a.rotate(count: 4)
        for r in 0..<7 {
            for c in 0..<4 {
                XCTAssertEqual(a[r, c], "\(r)_\(c)")
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
