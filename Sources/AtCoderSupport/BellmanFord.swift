/// ベルマン-フォード法を用いて、始点となる頂点からグラフ中の各頂点への最短距離を求めます。
///
/// - Parameters:
///     - graph: 最短距離を求める対象となるグラフ。
///              `graph.count` はグラフの頂点の数を表す。
///              `graph.edges` はグラフの辺を表し、 `from` 、 `to` はそれぞれ始点、終点の頂点のインデックスを表す。
///              `distance` はその辺の距離を表す。
///     - start: 始点となる頂点のインデックス。
/// - Returns: 0 番目の要素は`start` から各頂点への最短距離。到達不能な頂点への最短距離は `nil` 。
///            1 番目の要素 `hasNegativeWeightCycle` は負の閉路を持つかを表すフラグ。
func bellmanFord<Distance>(graph: (count: Int, edges: [(from: Int, to: Int, distance: Distance)]), startedAt start: Int) -> ([Distance?], hasNegativeWeightCycles: Bool) where Distance: Comparable, Distance: AdditiveArithmetic {
    precondition(graph.count > 0)
    var hasNegativeWeightCycles: Bool = false
    var result: [Distance?] = .init(repeating: nil, count: graph.count)
    result[start] = .zero
    
    let finalRound = graph.count - 1
    for round in 0 ..< graph.count {
        for (i, j, distance) in graph.edges {
            guard let totalDistanceToI = result[i] else { continue }
            let newTotalDistanceToJ = totalDistanceToI + distance
            if let totalDistanceToJ = result[j] {
                if newTotalDistanceToJ < totalDistanceToJ {
                    result[j] = newTotalDistanceToJ
                    if round == finalRound { hasNegativeWeightCycles = true }
                }
            } else {
                result[j] = newTotalDistanceToJ
                if round == finalRound { hasNegativeWeightCycles = true }
            }
        }
    }
    
    return (result, hasNegativeWeightCycles: hasNegativeWeightCycles)
}
