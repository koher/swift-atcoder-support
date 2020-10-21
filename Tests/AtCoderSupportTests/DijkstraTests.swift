import XCTest
@testable import AtCoderSupport

final class DijkstraTests: XCTestCase {
    func testDijkstra() {
        do {
            let graph: [[(index: Int, distance: Int)]] = [
                [
                    (index: 1, distance: 7),
                    (index: 2, distance: 9),
                    (index: 5, distance: 14),
                ],
                [
                    (index: 0, distance: 7),
                    (index: 2, distance: 10),
                    (index: 3, distance: 15),
                ],
                [
                    (index: 0, distance: 9),
                    (index: 1, distance: 10),
                    (index: 3, distance: 11),
                    (index: 5, distance: 2),
                ],
                [
                    (index: 1, distance: 15),
                    (index: 2, distance: 11),
                    (index: 4, distance: 6),
                ],
                [
                    (index: 3, distance: 6),
                    (index: 5, distance: 9),
                ],
                [
                    (index: 0, distance: 14),
                    (index: 4, distance: 9),
                ],
            ]
            let r = dijkstra(graph: graph, startedAt: 0)
            XCTAssertEqual(r, [0, 7, 9, 20, 20, 11])
        }
    }
}
