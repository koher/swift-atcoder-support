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
                let r = bellmanFord(graph: graph, startedAt: 0)
                XCTAssertEqual(r, [(0, false), (5, false), (8, false), (3, false), (7, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 1)
                XCTAssertEqual(r, [nil, (0, false), (3, false), (9, false), (2, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 2)
                XCTAssertEqual(r, [nil, (4, false), (0, false), (8, false), (1, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 3)
                XCTAssertEqual(r, [nil, (12, false), (8, false), (0, false), (7, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 4)
                XCTAssertEqual(r, [nil, (5, false), (1, false), (7, false), (0, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 5)
                XCTAssertEqual(r, [nil, nil, nil, nil, nil, (0, false), (6, false)])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 6)
                XCTAssertEqual(r, [nil, nil, nil, nil, nil, (6, false), (0, false)])
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
                let r = bellmanFord(graph: graph, startedAt: 0)
                XCTAssertEqual(r, [(0, false), (5, false), (4, false), (3, false), (3, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 1)
                XCTAssertEqual(r, [nil, (0, false), (-1, false), (5, false), (-2, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 2)
                XCTAssertEqual(r, [nil, (4, false), (0, false), (8, false), (1, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 3)
                XCTAssertEqual(r, [nil, (12, false), (8, false), (0, false), (7, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 4)
                XCTAssertEqual(r, [nil, (5, false), (1, false), (7, false), (0, false), nil, nil])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 5)
                XCTAssertEqual(r, [nil, nil, nil, nil, nil, (0, false), (6, false)])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 6)
                XCTAssertEqual(r, [nil, nil, nil, nil, nil, (6, false), (0, false)])
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
                let r = bellmanFord(graph: graph, startedAt: 0)
                XCTAssertEqual(r[0], (0, false))
                XCTAssertEqual(r[1]!.1, true)
                XCTAssertEqual(r[2]!.1, true)
                XCTAssertEqual(r[3]!.1, true)
                XCTAssertEqual(r[4]!.1, true)
                XCTAssertEqual(r[5], nil)
                XCTAssertEqual(r[6], nil)
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 1)
                XCTAssertEqual(r[0], nil)
                XCTAssertEqual(r[1]!.1, true)
                XCTAssertEqual(r[2]!.1, true)
                XCTAssertEqual(r[3]!.1, true)
                XCTAssertEqual(r[4]!.1, true)
                XCTAssertEqual(r[5], nil)
                XCTAssertEqual(r[6], nil)
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 3)
                XCTAssertEqual(r[0], nil)
                XCTAssertEqual(r[1]!.1, true)
                XCTAssertEqual(r[2]!.1, true)
                XCTAssertEqual(r[3]!.1, true)
                XCTAssertEqual(r[4]!.1, true)
                XCTAssertEqual(r[5], nil)
                XCTAssertEqual(r[6], nil)
                print(r)
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 4)
                XCTAssertEqual(r[0], nil)
                XCTAssertEqual(r[1]!.1, true)
                XCTAssertEqual(r[2]!.1, true)
                XCTAssertEqual(r[3]!.1, true)
                XCTAssertEqual(r[4]!.1, true)
                XCTAssertEqual(r[5], nil)
                XCTAssertEqual(r[6], nil)
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 5)
                XCTAssertEqual(r, [nil, nil, nil, nil, nil, (0, false), (6, false)])
            }
            do {
                let r = bellmanFord(graph: graph, startedAt: 6)
                XCTAssertEqual(r, [nil, nil, nil, nil, nil, (6, false), (0, false)])
            }
        }
    }
}

// FIXME: SE-0283 でタプルが Equatable になったら除去
private func XCTAssertEqual<T: Equatable>(_ expression1: [(T, Bool)?], _ expression2: [(T, Bool)?]) {
    XCTAssertEqual(expression1.count, expression2.count)
    guard expression1.count == expression2.count else { return }
    for (a, b) in zip(expression1, expression2) {
        XCTAssertEqual(a, b)
    }
}
private func XCTAssertEqual<T: Equatable>(_ expression1: (T, Bool)?, _ expression2: (T, Bool)?) {
    switch (expression1, expression2) {
    case (.some((let t1, let f1)), .some((let t2, let f2))):
        XCTAssertEqual(t1, t2)
        XCTAssertEqual(f1, f2)
    case (.some((let t1, let f1)), .none):
        XCTFail("(\(t1), \(f1)) != nil")
    case (.none, .some((let t2, let f2))):
        XCTFail("nil != (\(t2), \(f2))")
    case (.none, .none):
        break
    }
}
