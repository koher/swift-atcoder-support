struct UnionFind {
    private var parents: [Int]
    private var ranks: [Int]
    private let max: Int

    init(max: Int) {
        precondition(max >= 0)
        self.max = max
        self.parents = Array(0 ..< max)
        self.ranks = Array(repeating: 0, count: max)
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

    mutating func unite(_ x: Int, _ y: Int) {
        let x = root(of: x)
        let y = root(of: y)
        if x == y { return }
        if ranks[x] < ranks[y] {
            parents[x] = y
        } else {
            parents[y] = x
            if ranks[x] == ranks[y] {
                ranks[x] += 1
            }
        }
    }

    func areSame(_ x: Int, _ y: Int) -> Bool {
        root(of:x) == root(of:y)
    }
}
