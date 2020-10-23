import XCTest
@testable import AtCoderSupport

final class UnionFindTests: XCTestCase {
    func testUnionFind() {
        do {
            let n = 10
            var unionFind: UnionFind = .init(count: n)
            
            for i in 0 ..< n { // root
                XCTAssertEqual(unionFind.root(of: i), i)
            }
            for i in 0 ..< n { // areSame
                for j in 0 ..< n {
                    if i == j {
                        XCTAssertTrue(unionFind.areInSameSet(i, j))
                    } else {
                        XCTAssertFalse(unionFind.areInSameSet(i, j))
                    }
                }
            }

            unionFind.unite(2, 3)
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 3))
            do {
                let groups: [Set<Int>] = [[0], [1], [4], [5], [6], [7], [8], [9], [2, 3]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(of: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.areInSameSet(i, j))
                        } else {
                            XCTAssertFalse(unionFind.areInSameSet(i, j))
                        }
                    }
                }
            }
            
            unionFind.unite(5, 7)
            XCTAssertEqual(unionFind.root(of: 5), unionFind.root(of: 7))
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 3))
            do {
                let groups: [Set<Int>] = [[0], [1], [4], [6], [8], [9], [2, 3], [5, 7]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(of: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.areInSameSet(i, j))
                        } else {
                            XCTAssertFalse(unionFind.areInSameSet(i, j))
                        }
                    }
                }
            }

            unionFind.unite(1, 2)
            XCTAssertEqual(unionFind.root(of: 1), unionFind.root(of: 2))
            XCTAssertEqual(unionFind.root(of: 1), unionFind.root(of: 3))
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 3))
            XCTAssertEqual(unionFind.root(of: 5), unionFind.root(of: 7))
            do {
                let groups: [Set<Int>] = [[0], [4], [6], [8], [9], [1, 2, 3], [5, 7]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(of: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.areInSameSet(i, j))
                        } else {
                            XCTAssertFalse(unionFind.areInSameSet(i, j))
                        }
                    }
                }
            }
            
            unionFind.unite(3, 7)
            XCTAssertEqual(unionFind.root(of: 1), unionFind.root(of: 2))
            XCTAssertEqual(unionFind.root(of: 1), unionFind.root(of: 3))
            XCTAssertEqual(unionFind.root(of: 1), unionFind.root(of: 5))
            XCTAssertEqual(unionFind.root(of: 1), unionFind.root(of: 7))
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 1))
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 3))
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 5))
            XCTAssertEqual(unionFind.root(of: 2), unionFind.root(of: 7))
            XCTAssertEqual(unionFind.root(of: 3), unionFind.root(of: 1))
            XCTAssertEqual(unionFind.root(of: 3), unionFind.root(of: 2))
            XCTAssertEqual(unionFind.root(of: 3), unionFind.root(of: 5))
            XCTAssertEqual(unionFind.root(of: 3), unionFind.root(of: 7))
            XCTAssertEqual(unionFind.root(of: 5), unionFind.root(of: 1))
            XCTAssertEqual(unionFind.root(of: 5), unionFind.root(of: 2))
            XCTAssertEqual(unionFind.root(of: 5), unionFind.root(of: 3))
            XCTAssertEqual(unionFind.root(of: 5), unionFind.root(of: 7))
            XCTAssertEqual(unionFind.root(of: 7), unionFind.root(of: 1))
            XCTAssertEqual(unionFind.root(of: 7), unionFind.root(of: 2))
            XCTAssertEqual(unionFind.root(of: 7), unionFind.root(of: 3))
            XCTAssertEqual(unionFind.root(of: 7), unionFind.root(of: 5))
            do {
                let groups: [Set<Int>] = [[0], [4], [6], [8], [9], [1, 2, 3, 5, 7]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(of: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.areInSameSet(i, j))
                        } else {
                            XCTAssertFalse(unionFind.areInSameSet(i, j))
                        }
                    }
                }
            }
        }
    }
    
    #if !DEBUG
    func testUnionFindPerformance() {
        let n = 10_000_000
        measure {
            var unionFind: UnionFind = .init(count: n)
            for i in 1 ..< n {
                unionFind.unite(i - 1, i)
            }
            XCTAssertTrue(unionFind.areInSameSet(0, n - 1))
        }
    }
    #endif
}
