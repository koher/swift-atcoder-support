import XCTest
@testable import AtCoderSupport

final class DFSTests: XCTestCase {
    func testDFS() {
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
                dfs(edges: edges, startedAt: 0) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [0, 1, 3, 4, 2, 5, 6])
            }
            do { // Subtrees
                var r: [Int] = []
                dfs(edges: edges, startedAt: 2) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [2, 5, 6])
            }
            do { // Leaves
                var r: [Int] = []
                dfs(edges: edges, startedAt: 4) { i in
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
                dfs(edges: edges, startedAt: 0) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [0, 1, 3, 4, 2, 5, 6])
            }
            do {
                var r: [Int] = []
                dfs(edges: edges, startedAt: 2) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [2, 0, 1, 3, 4, 5, 6])
            }
            do {
                var r: [Int] = []
                dfs(edges: edges, startedAt: 4) { i in
                    r.append(i)
                }
                XCTAssertEqual(r, [4, 1, 0, 2, 5, 6, 3])
            }
        }
    }
    
    func testDFSWithPrev() {
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
                dfs(edges: edges, startedAt: 0) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [0, 1, 3, 4, 2, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 1, 1, 0, 2, 2])
            }
            do { // Subtrees
                var currents: [Int] = []
                var prevs: [Int?] = []
                dfs(edges: edges, startedAt: 2) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [2, 5, 6])
                XCTAssertEqual(prevs, [nil, 2, 2])
            }
            do { // Leaves
                var currents: [Int] = []
                var prevs: [Int?] = []
                dfs(edges: edges, startedAt: 4) { current, prev in
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
                dfs(edges: edges, startedAt: 0) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [0, 1, 3, 4, 2, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 1, 1, 0, 2, 2])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                dfs(edges: edges, startedAt: 2) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [2, 0, 1, 3, 4, 5, 6])
                XCTAssertEqual(prevs, [nil, 2, 0, 1, 1, 2, 2])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                dfs(edges: edges, startedAt: 4) { current, prev in
                    currents.append(current)
                    prevs.append(prev)
                }
                XCTAssertEqual(currents, [4, 1, 0, 2, 5, 6, 3])
                XCTAssertEqual(prevs, [nil, 4, 1, 0, 2, 2, 1])
            }
        }
    }
    
    func testDFSWithPrevDepth() {
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
                dfs(edges: edges, startedAt: 0) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [0, 1, 3, 4, 2, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 1, 1, 0, 2, 2])
                XCTAssertEqual(depths, [0, 1, 2, 2, 1, 2, 2])
            }
            do { // Subtrees
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                dfs(edges: edges, startedAt: 2) { current, prev, depth in
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
                dfs(edges: edges, startedAt: 4) { current, prev, depth in
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
                dfs(edges: edges, startedAt: 0) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [0, 1, 3, 4, 2, 5, 6])
                XCTAssertEqual(prevs, [nil, 0, 1, 1, 0, 2, 2])
                XCTAssertEqual(depths, [0, 1, 2, 2, 1, 2, 2])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                dfs(edges: edges, startedAt: 2) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [2, 0, 1, 3, 4, 5, 6])
                XCTAssertEqual(prevs, [nil, 2, 0, 1, 1, 2, 2])
                XCTAssertEqual(depths, [0, 1, 2, 3, 3, 1, 1])
            }
            do {
                var currents: [Int] = []
                var prevs: [Int?] = []
                var depths: [Int] = []
                dfs(edges: edges, startedAt: 4) { current, prev, depth in
                    currents.append(current)
                    prevs.append(prev)
                    depths.append(depth)
                }
                XCTAssertEqual(currents, [4, 1, 0, 2, 5, 6, 3])
                XCTAssertEqual(prevs, [nil, 4, 1, 0, 2, 2, 1])
                XCTAssertEqual(depths, [0, 1, 2, 3, 4, 4, 2])
            }
        }
    }
    
    func testDFSWithPath() {
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
                dfs(graph: graph, startedAt: 0) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [0],
                    [1, 0],
                    [3, 1, 0],
                    [4, 1, 0],
                    [2, 0],
                    [5, 2, 0],
                    [6, 2, 0],
                ])
            }
            do { // Subtrees
                var paths: [LinkedList<Int>] = []
                dfs(graph: graph, startedAt: 2) { path in
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
                dfs(graph: graph, startedAt: 4) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [4],
                ])
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
                dfs(graph: graph, startedAt: 0) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [0],
                    [1, 0],
                    [3, 1, 0],
                    [4, 1, 0],
                    [2, 0],
                    [5, 2, 0],
                    [6, 2, 0],
                ])
            }
            do {
                var paths: [LinkedList<Int>] = []
                dfs(graph: graph, startedAt: 2) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [2],
                    [0, 2],
                    [1, 0, 2],
                    [3, 1, 0, 2],
                    [4, 1, 0, 2],
                    [5, 2],
                    [6, 2],
                ])
            }
            do {
                var paths: [LinkedList<Int>] = []
                dfs(graph: graph, startedAt: 4) { path in
                    paths.append(path)
                }
                XCTAssertEqual(paths, [
                    [4],
                    [1, 4],
                    [0, 1, 4],
                    [2, 0, 1, 4],
                    [5, 2, 0, 1, 4],
                    [6, 2, 0, 1, 4],
                    [3, 1, 4],
                ])
            }
        }
    }

    #if !DEBUG
    func testDFSPerformance() {
        let n = (1 << 20) - 1
        let edges: [[Int]] = (1 ... n).map {
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
            dfs(edges: edges, startedAt: 0) { (_: Int) in count += 1 }
            XCTAssertEqual(count, edges.count)
        }
    }
    
    func testDFSWithPrevPerformance() {
        let n = (1 << 20) - 1
        let edges: [[Int]] = (1 ... n).map {
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
            dfs(edges: edges, startedAt: 0) { _, _ in count += 1 }
            XCTAssertEqual(count, edges.count)
        }
    }
    
    func testDFSWithPrevDepthPerformance() {
        let n = (1 << 20) - 1
        let edges: [[Int]] = (1 ... n).map {
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
            dfs(edges: edges, startedAt: 0) { _, _, _ in count += 1 }
            XCTAssertEqual(count, edges.count)
        }
    }

    func testDFSWithPathPerformance() {
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
            dfs(graph: graph, startedAt: 0) { (_: LinkedList<Int>) in count += 1 }
            XCTAssertEqual(count, graph.count)
        }
    }
    #endif
}
