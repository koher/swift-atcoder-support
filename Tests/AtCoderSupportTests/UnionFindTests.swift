import XCTest
@testable import AtCoderSupport

final class UnionFindTests: XCTestCase {
    func testUnionFind() {
        do {
            let n = 10
            var unionFind: UnionFind = .init(n: n)
            
            for i in 0 ..< n { // root
                XCTAssertEqual(unionFind.root(x: i), i)
            }
            for i in 0 ..< n { // areSame
                for j in 0 ..< n {
                    if i == j {
                        XCTAssertTrue(unionFind.same(x: i, y: j))
                    } else {
                        XCTAssertFalse(unionFind.same(x: i, y: j))
                    }
                }
            }

            unionFind.unite(x: 2, y: 3)
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 3))
            do {
                let groups: [Set<Int>] = [[0], [1], [4], [5], [6], [7], [8], [9], [2, 3]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(x: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.same(x: i, y: j))
                        } else {
                            XCTAssertFalse(unionFind.same(x: i, y: j))
                        }
                    }
                }
            }
            
            unionFind.unite(x: 5, y: 7)
            XCTAssertEqual(unionFind.root(x: 5), unionFind.root(x: 7))
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 3))
            do {
                let groups: [Set<Int>] = [[0], [1], [4], [6], [8], [9], [2, 3], [5, 7]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(x: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.same(x: i, y: j))
                        } else {
                            XCTAssertFalse(unionFind.same(x: i, y: j))
                        }
                    }
                }
            }

            unionFind.unite(x: 1, y: 2)
            XCTAssertEqual(unionFind.root(x: 1), unionFind.root(x: 2))
            XCTAssertEqual(unionFind.root(x: 1), unionFind.root(x: 3))
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 3))
            XCTAssertEqual(unionFind.root(x: 5), unionFind.root(x: 7))
            do {
                let groups: [Set<Int>] = [[0], [4], [6], [8], [9], [1, 2, 3], [5, 7]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(x: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.same(x: i, y: j))
                        } else {
                            XCTAssertFalse(unionFind.same(x: i, y: j))
                        }
                    }
                }
            }
            
            unionFind.unite(x: 3, y: 7)
            XCTAssertEqual(unionFind.root(x: 1), unionFind.root(x: 2))
            XCTAssertEqual(unionFind.root(x: 1), unionFind.root(x: 3))
            XCTAssertEqual(unionFind.root(x: 1), unionFind.root(x: 5))
            XCTAssertEqual(unionFind.root(x: 1), unionFind.root(x: 7))
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 1))
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 3))
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 5))
            XCTAssertEqual(unionFind.root(x: 2), unionFind.root(x: 7))
            XCTAssertEqual(unionFind.root(x: 3), unionFind.root(x: 1))
            XCTAssertEqual(unionFind.root(x: 3), unionFind.root(x: 2))
            XCTAssertEqual(unionFind.root(x: 3), unionFind.root(x: 5))
            XCTAssertEqual(unionFind.root(x: 3), unionFind.root(x: 7))
            XCTAssertEqual(unionFind.root(x: 5), unionFind.root(x: 1))
            XCTAssertEqual(unionFind.root(x: 5), unionFind.root(x: 2))
            XCTAssertEqual(unionFind.root(x: 5), unionFind.root(x: 3))
            XCTAssertEqual(unionFind.root(x: 5), unionFind.root(x: 7))
            XCTAssertEqual(unionFind.root(x: 7), unionFind.root(x: 1))
            XCTAssertEqual(unionFind.root(x: 7), unionFind.root(x: 2))
            XCTAssertEqual(unionFind.root(x: 7), unionFind.root(x: 3))
            XCTAssertEqual(unionFind.root(x: 7), unionFind.root(x: 5))
            do {
                let groups: [Set<Int>] = [[0], [4], [6], [8], [9], [1, 2, 3, 5, 7]]
                for i in 0 ..< n { // root
                    if groups.first(where: { $0.contains(i) })!.count > 1 { continue }
                    XCTAssertEqual(unionFind.root(x: i), i)
                }
                for i in 0 ..< n { // areSame
                    for j in 0 ..< n {
                        if groups.reduce(false, { $0 || $1.contains(i) && $1.contains(j)}) {
                            XCTAssertTrue(unionFind.same(x: i, y: j))
                        } else {
                            XCTAssertFalse(unionFind.same(x: i, y: j))
                        }
                    }
                }
            }
        }
    }
}
