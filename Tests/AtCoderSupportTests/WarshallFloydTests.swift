import XCTest
@testable import AtCoderSupport

final class WarshallFloydTests: XCTestCase {
    func testWarshallFloyd() {
        do {
            // A -- 5 -> B <-- 4 --> C
            // |         |           ^
            // |         |           |
            // 3         2     1 -----
            // |         |     |
            // V         V     |
            // D <- 7 -> E <----
            //
            // F <- 6 -> G
            var graph: [[Int?]] = [
                [0, 5, nil, 3, nil, nil, nil],
                [nil, 0, 4, nil, 2, nil, nil],
                [nil, 4, 0, nil, 1, nil, nil],
                [nil, nil, nil, 0, 7, nil, nil],
                [nil, nil, 1, 7, 0, nil, nil],
                [nil, nil, nil, nil, nil, 0, 6],
                [nil, nil, nil, nil, nil, 6, 0],
            ]
            warshallFloyd(graph: &graph)
            
            XCTAssertEqual(graph, [
                [0, 5, 8, 3, 7, nil, nil],
                [nil, 0, 3, 9, 2, nil, nil],
                [nil, 4, 0, 8, 1, nil, nil],
                [nil, 12, 8, 0, 7, nil, nil],
                [nil, 5, 1, 7, 0, nil, nil],
                [nil, nil, nil, nil, nil, 0, 6],
                [nil, nil, nil, nil, nil, 6, 0],
            ])
        }
        do { // 負の辺
            // A -- 5 -> B <-- 4 --> C
            // |         |           ^
            // |         |           |
            // 3        -2     1 -----
            // |         |     |
            // V         V     |
            // D <- 7 -> E <----
            //
            // F <- 6 -> G
            var graph: [[Int?]] = [
                [0, 5, nil, 3, nil, nil, nil],
                [nil, 0, 4, nil, -2, nil, nil],
                [nil, 4, 0, nil, 1, nil, nil],
                [nil, nil, nil, 0, 7, nil, nil],
                [nil, nil, 1, 7, 0, nil, nil],
                [nil, nil, nil, nil, nil, 0, 6],
                [nil, nil, nil, nil, nil, 6, 0],
            ]
            warshallFloyd(graph: &graph)
            
            XCTAssertEqual(graph, [
                [0, 5, 4, 3, 3, nil, nil],
                [nil, 0, -1, 5, -2, nil, nil],
                [nil, 4, 0, 8, 1, nil, nil],
                [nil, 12, 8, 0, 7, nil, nil],
                [nil, 5, 1, 7, 0, nil, nil],
                [nil, nil, nil, nil, nil, 0, 6],
                [nil, nil, nil, nil, nil, 6, 0],
            ])
        }
        do { // 負の閉路
            // A -- 5 -> B <-- 2 --> C
            // |         |           ^
            // |         |           |
            // 3        -4     1 -----
            // |         |     |
            // V         V     |
            // D <- 7 -> E <----
            //
            // F <- 6 -> G
            var graph: [[Int?]] = [
                [0, 5, nil, 3, nil, nil, nil],
                [nil, 0, 2, nil, -4, nil, nil],
                [nil, 2, 0, nil, 1, nil, nil],
                [nil, nil, nil, 0, 7, nil, nil],
                [nil, nil, 1, 7, 0, nil, nil],
                [nil, nil, nil, nil, nil, 0, 6],
                [nil, nil, nil, nil, nil, 6, 0],
            ]
            warshallFloyd(graph: &graph)

            XCTAssertTrue(graph[1][1]! < 0)
            XCTAssertTrue(graph[2][2]! < 0)
            XCTAssertTrue(graph[4][4]! < 0)
            XCTAssertEqual(graph[5], [nil, nil, nil, nil, nil, 0, 6])
            XCTAssertEqual(graph[6], [nil, nil, nil, nil, nil, 6, 0])
        }
    }
}
