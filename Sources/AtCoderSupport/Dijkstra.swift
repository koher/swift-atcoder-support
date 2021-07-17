// ❗ 利用時に `PriorityQueue` のコピーが必要

/// ダイクストラ法を用いて、始点となる頂点からグラフ中の各頂点への最短距離を求めます。
///
/// - Parameters:
///     - graph: 最短距離を求める対象となるグラフ。
///              `graph[i][j]` はグラフの `i` 番目の頂点から他の頂点への `j` 番目の辺を表す。
///              辺の行き先となる頂点のインデックスを `index` で、辺の距離を `distance` で表す。
///     - start: 始点となる頂点のインデックス。
/// - Returns: `start` から各頂点への最短距離。到達不能な頂点への最短距離は `nil` 。
func dijkstra<Distance>(graph: [[(index: Int, distance: Distance)]], startedAt start: Int) -> [Distance?] where Distance: Comparable, Distance: AdditiveArithmetic {
    var result: [Distance?] = .init(repeating: nil, count: graph.count)
    result[start] = .zero
    var queue = PriorityQueue<(Distance, Int)>(by: { $0.0 < $1.0 })
    queue.append((.zero, start))
    while let (totalDistanceToI, i) = queue.popFirst() {
        guard let minTotalDistanceToI = result[i] else { preconditionFailure("Never reaches here.") }
        if minTotalDistanceToI < totalDistanceToI { continue }
        assert(totalDistanceToI == minTotalDistanceToI)
        for (j, distance) in graph[i] {
            if let totalDistanceToJ = result[j] {
                let newTotalDistanceToJ = totalDistanceToI + distance
                if newTotalDistanceToJ < totalDistanceToJ {
                    result[j] = newTotalDistanceToJ
                    queue.append((newTotalDistanceToJ, j))
                }
            } else {
                let newTotalDistanceToJ = totalDistanceToI + distance
                result[j] = newTotalDistanceToJ
                queue.append((newTotalDistanceToJ, j))
            }
        }
    }
    return result
}
