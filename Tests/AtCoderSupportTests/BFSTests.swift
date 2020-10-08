import XCTest
@testable import AtCoderSupport

final class BFSTests: XCTestCase {
    func testBFS() {
        do { // Trees
            // 0 --+-> 1 --+-> 3
            //     |       +-> 4
            //     +-> 2 --+-> 5
            //             +-> 6
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
                var r: [Int] = []
                bfs(edges: edges, startedAt: 0) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [0, 1, 2, 3, 4, 5, 6])
            }
            do { // Subtrees
                var r: [Int] = []
                bfs(edges: edges, startedAt: 2) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [2, 5, 6])
            }
            do { // Leaves
                var r: [Int] = []
                bfs(edges: edges, startedAt: 4) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [4])
            }
        }
        
        do { // Complex Graphs
            //  0 <-+-> 1 <-+-> 3 --> 0
            // ^^   |       +-> 4 --> 0
            // ||   +-> 2 <-+-> 5 --> 0
            // ++           +-> 6 --> 0
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
                var r: [Int] = []
                bfs(edges: edges, startedAt: 0) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [0, 1, 2, 3, 4, 5, 6])
            }
            do {
                var r: [Int] = []
                bfs(edges: edges, startedAt: 2) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [2, 0, 5, 6, 1, 3, 4])
            }
            do {
                var r: [Int] = []
                bfs(edges: edges, startedAt: 4) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [4, 1, 0, 3, 2, 5, 6])
            }
        }
    }
    
    func testBFSWithPrev() {
        do { // Trees
            // 0 --+-> 1 --+-> 3
            //     |       +-> 4
            //     +-> 2 --+-> 5
            //             +-> 6
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
                var currents: [Int] = []
                var prevs: [Int?] = []
                bfs(edges: edges, startedAt: 0) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [0, 1, 2, 3, 4, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 0, 1, 1, 2, 2])
            }
            do { // Subtrees
                var currents: [Int] = []
                var prevs: [Int?] = []
                bfs(edges: edges, startedAt: 2) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [2, 5, 6])
                XCTAssertEqual(prevs, [nil, 2, 2])
            }
            do { // Leaves
                var currents: [Int] = []
                var prevs: [Int?] = []
                bfs(edges: edges, startedAt: 4) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [4])
                XCTAssertEqual(prevs, [nil])
            }
        }
        
        do { // Complex Graphs
            //  0 <-+-> 1 <-+-> 3 --> 0
            // ^^   |       +-> 4 --> 0
            // ||   +-> 2 <-+-> 5 --> 0
            // ++           +-> 6 --> 0
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
                var currents: [Int] = []
                var prevs: [Int?] = []
                bfs(edges: edges, startedAt: 0) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [0, 1, 2, 3, 4, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 0, 1, 1, 2, 2])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                bfs(edges: edges, startedAt: 2) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [2, 0, 5, 6, 1, 3, 4])
                XCTAssertEqual(prevs, [nil, 2, 2, 2, 0, 1, 1])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                bfs(edges: edges, startedAt: 4) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [4, 1, 0, 3, 2, 5, 6])
                XCTAssertEqual(prevs, [nil, 4, 4, 1, 0, 2, 2])
            }
        }
    }
    
    func testBFSWithPrevDepth() {
        do { // Trees
            // 0 --+-> 1 --+-> 3
            //     |       +-> 4
            //     +-> 2 --+-> 5
            //             +-> 6
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
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                bfs(edges: edges, startedAt: 0) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [0, 1, 2, 3, 4, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 0, 1, 1, 2, 2])
                XCTAssertEqual(depths, [0, 1, 1, 2, 2, 2, 2])
            }
            do { // Subtrees
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                bfs(edges: edges, startedAt: 2) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [2, 5, 6])
                XCTAssertEqual(prevs, [nil, 2, 2])
                XCTAssertEqual(depths, [0, 1, 1])
            }
            do { // Leaves
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                bfs(edges: edges, startedAt: 4) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [4])
                XCTAssertEqual(prevs, [nil])
                XCTAssertEqual(depths, [0])
            }
        }
        
        do { // Complex Graphs
            //  0 <-+-> 1 <-+-> 3 --> 0
            // ^^   |       +-> 4 --> 0
            // ||   +-> 2 <-+-> 5 --> 0
            // ++           +-> 6 --> 0
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
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                bfs(edges: edges, startedAt: 0) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [0, 1, 2, 3, 4, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 0, 1, 1, 2, 2])
                XCTAssertEqual(depths, [0, 1, 1, 2, 2, 2, 2])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                bfs(edges: edges, startedAt: 2) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [2, 0, 5, 6, 1, 3, 4])
                XCTAssertEqual(prevs, [nil, 2, 2, 2, 0, 1, 1])
                XCTAssertEqual(depths, [0, 1, 1, 1, 2, 3, 3])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                bfs(edges: edges, startedAt: 4) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [4, 1, 0, 3, 2, 5, 6])
                XCTAssertEqual(prevs, [nil, 4, 4, 1, 0, 2, 2])
                XCTAssertEqual(depths, [0, 1, 1, 2, 2, 3, 3])
            }
        }
    }
}
