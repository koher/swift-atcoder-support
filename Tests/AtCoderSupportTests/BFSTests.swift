import XCTest
@testable import AtCoderSupport

final class BFSTests: XCTestCase {
    func testBFS() {
        do { // Trees
            // 0 --+-> 1 --+-> 3
            //     |       +-> 4
            //     +-> 2 --+-> 5
            //             +-> 6
            let graph = [
                [1, 2],
                [3, 4],
                [5, 6],
                [],
                [],
                [],
                [],
            ]
            
            do {
                var paths: [LinkedList<Int>] = []
                bfs(graph: graph, startedAt: 0) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [0],
                    [1, 0],
                    [2, 0],
                    [3, 1, 0],
                    [4, 1, 0],
                    [5, 2, 0],
                    [6, 2, 0],
                ])
            }
            do { // Subtrees
                var paths: [LinkedList<Int>] = []
                bfs(graph: graph, startedAt: 2) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [2],
                    [5, 2],
                    [6, 2],
                ])
            }
            do { // Leaves
                var paths: [LinkedList<Int>] = []
                bfs(graph: graph, startedAt: 4) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [[4]])
            }
        }
        
        do { // Complex Graphs
            //  0 <-+-> 1 <-+-> 3 --> 0
            // ^^   |       +-> 4 --> 0
            // ||   +-> 2 <-+-> 5 --> 0
            // ++           +-> 6 --> 0
            let graph = [
                [0, 1, 2],
                [0, 3, 4],
                [0, 5, 6],
                [1, 0],
                [1, 0],
                [2, 0],
                [2, 0],
            ]
            
            do {
                var paths: [LinkedList<Int>] = []
                bfs(graph: graph, startedAt: 0) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [0],
                    [1, 0],
                    [2, 0],
                    [3, 1, 0],
                    [4, 1, 0],
                    [5, 2, 0],
                    [6, 2, 0],
                ])
            }
            do {
                var paths: [LinkedList<Int>] = []
                bfs(graph: graph, startedAt: 2) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [2],
                    [0, 2],
                    [5, 2],
                    [6, 2],
                    [1, 0, 2],
                    [3, 1, 0, 2],
                    [4, 1, 0, 2],
                ])
            }
            do {
                var paths: [LinkedList<Int>] = []
                bfs(graph: graph, startedAt: 4) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [4],
                    [1, 4],
                    [0, 4],
                    [3, 1, 4],
                    [2, 0, 4],
                    [5, 2, 0, 4],
                    [6, 2, 0, 4],
                ])
            }
        }
    }

    #if !DEBUG
    func testBFSPerformance() {
        let n = (1 << 20) - 1
        let graph: [[Int]] = (1 ... n).map {
            let left = $0 << 1
            let right = left + 1
            if right <= n {
                return [left - 1, right - 1]
            } else if left <= n {
                return [left - 1]
            } else {
                return []
            }
        }
        measure {
            var count = 0
            bfs(graph: graph, startedAt: 0) { _ in count += 1 }
            XCTAssertEqual(count, graph.count)
        }
    }
    #endif
}
