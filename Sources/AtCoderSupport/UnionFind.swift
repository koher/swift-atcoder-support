struct UnionFind {
    private var parents: [Int]
    private var ranks: [Int]
    private var counts: [Int]

    init(count: Int) {
        precondition(count >= 0)
        self.parents = Array(0 ..< count)
        self.ranks = Array(repeating: 0, count: count)
        self.counts = Array(repeating: 1, count: count)
    }

    func root(of i: Int) -> Int {
        var current = i
        while true {
            let parent = parents[current]
            if current == parent { break }
            current = parent
        }
        return current
    }
    
    func count(of i: Int) -> Int {
        counts[root(of: i)]
    }

    mutating func unite(_ x: Int, _ y: Int) {
        let x = root(of: x)
        let y = root(of: y)
        if x == y { return }
        if ranks[x] < ranks[y] {
            counts[y] += counts[x]
            parents[x] = y
        } else {
            counts[x] += counts[y]
            parents[y] = x
            if ranks[x] == ranks[y] {
                ranks[x] += 1
            }
        }
    }

    func areInSameSet(_ x: Int, _ y: Int) -> Bool {
        root(of:x) == root(of:y)
    }
}
