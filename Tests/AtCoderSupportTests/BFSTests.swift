import XCTest
@testable import AtCoderSupport

final class BFSTests: XCTestCase {
    func testBFS() {
        do { // Trees
            // A1 --+-> B1 --+-> C1
            //      |        +-> C2
            //      +-> B2 --+-> C3
            //               +-> C4
            let nodes = ["A1", "B1", "B2", "C1", "C2", "C3", "C4"]
            let edges = [
                [1, 2],
                [3, 4],
                [5, 6],
                [],
                [],
                [],
                [],
            ]
            
            do {
                var r: [String] = []
                bfs(nodes: nodes, edges: edges, startedAt: 0) { node in
                    r.append(node)
                }
                XCTAssertEqual(r, ["A1", "B1", "B2", "C1", "C2", "C3", "C4"])
            }
            do { // Subtrees
                var r: [String] = []
                bfs(nodes: nodes, edges: edges, startedAt: 2) { node in
                    r.append(node)
                }
                XCTAssertEqual(r, ["B2", "C3", "C4"])
            }
            do { // Leaves
                var r: [String] = []
                bfs(nodes: nodes, edges: edges, startedAt: 4) { node in
                    r.append(node)
                }
                XCTAssertEqual(r, ["C2"])
            }
        }
        
        do { // Complex Graphs
            // A1 <-+-> B1 <-+-> C1 --> A1
            // ^^   |        +-> C2 --> A1
            // ||   +-> B2 <-+-> C3 --> A1
            // ++            +-> C4 --> A1
            let nodes = ["A1", "B1", "B2", "C1", "C2", "C3", "C4"]
            let edges = [
                [0, 1, 2],
                [0, 3, 4],
                [0, 5, 6],
                [1, 0],
                [1, 0],
                [2, 0],
                [2, 0],
            ]
            
            do {
                var r: [String] = []
                bfs(nodes: nodes, edges: edges, startedAt: 0) { node in
                    r.append(node)
                }
                XCTAssertEqual(r, ["A1", "B1", "B2", "C1", "C2", "C3", "C4"])
            }
            do {
                var r: [String] = []
                bfs(nodes: nodes, edges: edges, startedAt: 2) { node in
                    r.append(node)
                }
                XCTAssertEqual(r, ["B2", "A1", "C3", "C4", "B1", "C1", "C2"])
            }
            do {
                var r: [String] = []
                bfs(nodes: nodes, edges: edges, startedAt: 4) { node in
                    r.append(node)
                }
                XCTAssertEqual(r, ["C2", "B1", "A1", "C1", "B2", "C3", "C4"])
            }
        }
    }
    
    func testBFSInout() {
        do { // Trees
            // 10 --+-> 20 --+-> 40
            //      |        +-> 50
            //      +-> 30 --+-> 60
            //               +-> 70
            let edges = [
                [1, 2],
                [3, 4],
                [5, 6],
                [],
                [],
                [],
                [],
            ]
            
            do {
                var nodes = [10, 20, 30, 40, 50, 60, 70]
                var count = 0
                bfs(nodes: &nodes, edges: edges, startedAt: 0) { node in
                    count += 1
                    node += count
                }
                XCTAssertEqual(nodes, [11, 22, 33, 44, 55, 66, 77])
            }
            do { // Subtrees
                var nodes = [10, 20, 30, 40, 50, 60, 70]
                var count = 0
                bfs(nodes: &nodes, edges: edges, startedAt: 2) { node in
                    count += 1
                    node += count
                }
                XCTAssertEqual(nodes, [10, 20, 31, 40, 50, 62, 73])
            }
            do { // Leaves
                var nodes = [10, 20, 30, 40, 50, 60, 70]
                var count = 0
                bfs(nodes: &nodes, edges: edges, startedAt: 4) { node in
                    count += 1
                    node += count
                }
                XCTAssertEqual(nodes, [10, 20, 30, 40, 51, 60, 70])
            }
        }
        
        do { // Complex Graphs
            // A1 <-+-> B1 <-+-> C1 --> A1
            // ^^   |        +-> C2 --> A1
            // ||   +-> B2 <-+-> C3 --> A1
            // ++            +-> C4 --> A1
            let edges = [
                [0, 1, 2],
                [0, 3, 4],
                [0, 5, 6],
                [1, 0],
                [1, 0],
                [2, 0],
                [2, 0],
            ]
            
            do {
                var nodes = [10, 20, 30, 40, 50, 60, 70]
                var count = 0
                bfs(nodes: &nodes, edges: edges, startedAt: 0) { node in
                    count += 1
                    node += count
                }
                XCTAssertEqual(nodes, [11, 22, 33, 44, 55, 66, 77])
            }
            do {
                var nodes = [10, 20, 30, 40, 50, 60, 70]
                var count = 0
                bfs(nodes: &nodes, edges: edges, startedAt: 2) { node in
                    count += 1
                    node += count
                }
                XCTAssertEqual(nodes, [12, 25, 31, 46, 57, 63, 74])
            }
            do {
                var nodes = [10, 20, 30, 40, 50, 60, 70]
                var count = 0
                bfs(nodes: &nodes, edges: edges, startedAt: 4) { node in
                    count += 1
                    node += count
                }
                XCTAssertEqual(nodes, [13, 22, 35, 44, 51, 66, 77])
            }
        }
    }
}
