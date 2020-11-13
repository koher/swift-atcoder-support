import XCTest
@testable import AtCoderSupport

final class BellmanFordTests: XCTestCase {
    func testBellmanFord() {
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
            let graph = (count: 7, edges: [
                (from: 0, to: 1, distance: 5),
                (from: 0, to: 3, distance: 3),
                (from: 1, to: 2, distance: 4),
                (from: 1, to: 4, distance: 2),
                (from: 2, to: 1, distance: 4),
                (from: 2, to: 4, distance: 1),
                (from: 3, to: 4, distance: 7),
                (from: 4, to: 2, distance: 1),
                (from: 4, to: 3, distance: 7),
                (from: 5, to: 6, distance: 6),
                (from: 6, to: 5, distance: 6),
            ])
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 0)
                XCTAssertEqual(distances, [0, 5, 8, 3, 7, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 1)
                XCTAssertEqual(distances, [nil, 0, 3, 9, 2, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 2)
                XCTAssertEqual(distances, [nil, 4, 0, 8, 1, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 3)
                XCTAssertEqual(distances, [nil, 12, 8, 0, 7, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 4)
                XCTAssertEqual(distances, [nil, 5, 1, 7, 0, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 5)
                XCTAssertEqual(distances, [nil, nil, nil, nil, nil, 0, 6])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 6)
                XCTAssertEqual(distances, [nil, nil, nil, nil, nil, 6, 0])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
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
            let graph = (count: 7, edges: [
                (from: 0, to: 1, distance: 5),
                (from: 0, to: 3, distance: 3),
                (from: 1, to: 2, distance: 4),
                (from: 1, to: 4, distance: -2),
                (from: 2, to: 1, distance: 4),
                (from: 2, to: 4, distance: 1),
                (from: 3, to: 4, distance: 7),
                (from: 4, to: 2, distance: 1),
                (from: 4, to: 3, distance: 7),
                (from: 5, to: 6, distance: 6),
                (from: 6, to: 5, distance: 6),
            ])
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 0)
                XCTAssertEqual(distances, [0, 5, 4, 3, 3, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 1)
                XCTAssertEqual(distances, [nil, 0, -1, 5, -2, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 2)
                XCTAssertEqual(distances, [nil, 4, 0, 8, 1, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 3)
                XCTAssertEqual(distances, [nil, 12, 8, 0, 7, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 4)
                XCTAssertEqual(distances, [nil, 5, 1, 7, 0, nil, nil])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 5)
                XCTAssertEqual(distances, [nil, nil, nil, nil, nil, 0, 6])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 6)
                XCTAssertEqual(distances, [nil, nil, nil, nil, nil, 6, 0])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
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
            let graph = (count: 7, edges: [
                (from: 0, to: 1, distance: 5),
                (from: 0, to: 3, distance: 3),
                (from: 1, to: 2, distance: 2),
                (from: 1, to: 4, distance: -4),
                (from: 2, to: 1, distance: 2),
                (from: 2, to: 4, distance: 1),
                (from: 3, to: 4, distance: 7),
                (from: 4, to: 2, distance: 1),
                (from: 4, to: 3, distance: 7),
                (from: 5, to: 6, distance: 6),
                (from: 6, to: 5, distance: 6),
            ])
            do {
                let (_, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 0)
                XCTAssertTrue(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 5)
                XCTAssertEqual(distances, [nil, nil, nil, nil, nil, 0, 6])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
            do {
                let (distances, hasNegativeWeightCycles) = bellmanFord(graph: graph, startedAt: 6)
                XCTAssertEqual(distances, [nil, nil, nil, nil, nil, 6, 0])
                XCTAssertFalse(hasNegativeWeightCycles)
            }
        }
    }
}
