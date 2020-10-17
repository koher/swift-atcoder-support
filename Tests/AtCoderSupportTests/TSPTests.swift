import XCTest
@testable import AtCoderSupport

final class TSPTests: XCTestCase {
    func testTSP() {
        do {
            let distances: [[Int]] = [
                [0, 6],
                [3, 0],
            ]
            do {
                let r = tsp(distances: distances, startedAt: 0)
                XCTAssertEqual(r, 9)
            }
            do {
                let r = tsp(distances: distances, startedAt: 1)
                XCTAssertEqual(r, 9)
            }
        }
        do {
            let distances: [[Int]] = [
                [0, 3, 2],
                [2, 0, 4],
                [3, 6, 0],
            ]
            do {
                let r = tsp(distances: distances, startedAt: 0)
                XCTAssertEqual(r, 10)
            }
            do {
                let r = tsp(distances: distances, startedAt: 1)
                XCTAssertEqual(r, 10)
            }
            do {
                let r = tsp(distances: distances, startedAt: 1)
                XCTAssertEqual(r, 10)
            }
        }
        do {
            let distances: [[Int]] = [
                [0, 6, 5, 5],
                [6, 0, 7, 4],
                [5, 7, 0, 3],
                [5, 4, 3, 0]
            ]
            do {
                let r = tsp(distances: distances, startedAt: 0)
                XCTAssertEqual(r, 18)
            }
        }
    }
    
    #if !DEBUG
    func testTSPPerformance() {
        let positions: [(Int, Int, Int)] = [
            (14142, 13562, 373095),
            (-17320, 508075, 68877),
            (223606, -79774, 9979),
            (-24494, -89742, 783178),
            (26457, 513110, -64591),
            (-282842, 7124, -74619),
            (31622, -77660, -168379),
            (-33166, -24790, -3554),
            (346410, 16151, 37755),
            (-36055, 51275, 463989),
            (37416, -573867, 73941),
            (-3872, -983346, 207417),
            (412310, 56256, -17661),
            (-42426, 40687, -119285),
            (43588, -989435, -40674),
            (-447213, -59549, -99579),
            (45825, 7569, 45584),
        ]
        func distance(from p1: (Int, Int, Int), to p2: (Int, Int, Int)) -> Int {
            abs(p2.0 - p1.0) + abs(p2.1 - p1.1) + Swift.max(0, p2.2 - p1.2)
        }
        let distances: [[Int]] = positions.indices.map { i in positions.indices.map { j in distance(from: positions[i], to: positions[j]) } }
        
        measure {
            let r = tsp(distances: distances, startedAt: 0)
            XCTAssertEqual(r, 6519344)
        }
    }
    #endif
}
