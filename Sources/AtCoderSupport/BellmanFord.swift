/// ベルマン-フォード法を用いて、始点となる頂点からグラフ中の各頂点への最短距離を求めます。
///
/// - Parameters:
///     - graph: 最短距離を求める対象となるグラフ。
///              `graph.count` はグラフの頂点の数を表す。
///              `graph.edges` はグラフの辺を表し、 `from` 、 `to` はそれぞれ始点、終点の頂点のインデックスを表す。
///              `distance` はその辺の距離を表す。
///     - start: 始点となる頂点のインデックス。
/// - Returns: `start` から各頂点への最短距離と、その頂点への経路が負の閉路を持つかを表すフラグ。
func bellmanFord<Distance>(graph: (count: Int, edges: [(from: Int, to: Int, distance: Distance)]), startedAt start: Int) -> [(Distance, hasNegativeWeightCycles: Bool)?] where Distance: Comparable, Distance: AdditiveArithmetic {
    precondition(graph.count > 0)
    
    var totalDistances: [Distance?] = .init(repeating: nil, count: graph.count)
    totalDistances[start] = .zero
    
    let finalRound = graph.count - 1
    for _ in 0 ..< finalRound {
        for (i, j, distance) in graph.edges {
            guard let totalDistanceToI = totalDistances[i] else { continue }
            let newTotalDistanceToJ = totalDistanceToI + distance
            if let totalDistanceToJ = totalDistances[j] {
                if newTotalDistanceToJ < totalDistanceToJ {
                    totalDistances[j] = newTotalDistanceToJ
                }
            } else {
                totalDistances[j] = newTotalDistanceToJ
            }
        }
    }
    
    var isUpdated: [Bool] = .init(repeating: false, count: graph.count)
    for (i, j, distance) in graph.edges {
        guard let totalDistanceToI = totalDistances[i] else { continue }
        let newTotalDistanceToJ = totalDistanceToI + distance
        if let totalDistanceToJ = totalDistances[j] {
            if newTotalDistanceToJ < totalDistanceToJ {
                totalDistances[j] = newTotalDistanceToJ
                isUpdated[j] = true
            }
        } else {
            totalDistances[j] = newTotalDistanceToJ
            isUpdated[j] = true
        }
    }
    
    func _dfs(edges: [[Int]], startedAt start: Int, _ body: (Int) -> Void) {
        precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
        var isVisited: [Bool] = .init(repeating: false, count: edges.count)
        var destinations: [Int] = [start]
        while let current = destinations.popLast() {
            if isVisited[current] { continue }
            body(current)
            isVisited[current] = true
            for destination in edges[current].reversed() {
                destinations.append(destination)
            }
        }
    }

    var edges: [[Int]] = .init(repeating: [], count: graph.count)
    for (from, to, _) in graph.edges {
        edges[from].append(to)
    }

    var hasNegativeWeightCycles: [Bool] = .init(repeating: false, count: graph.count)
    for (i, isUpdated) in isUpdated.enumerated() {
        guard isUpdated else { continue }
        if hasNegativeWeightCycles[i] { continue }
        _dfs(edges: edges, startedAt: i) { j in hasNegativeWeightCycles[j] = true }
    }

    return zip(totalDistances, hasNegativeWeightCycles).map { d, f in d.map { ($0, f) } }
}
