func tsp<Distance>(distances: [[Distance]], startedAt start: Int) -> Distance where Distance: Comparable, Distance: AdditiveArithmetic {
    precondition(!distances.isEmpty)
    var results: [[Distance?]] = (0 ..< (1 << distances.count)).map { _ in [Distance?](repeating: nil, count: distances.count) }
    results[(1 << distances.count) - 1] = distances.indices.map { distances[$0][start] }
    for visited in (0 ..< (1 << distances.count) - 1).reversed() {
        if visited & (1 << start) == 0 { continue }
        for position in distances.indices {
            var minDistance: Distance?
            if visited & (1 << position) == 0 { continue }
            for next in distances.indices {
                if visited & (1 << next) != 0 { continue }
                let distanceToNext: Distance = distances[position][next]
                let distance = distanceToNext + results[visited | (1 << next)][next]!
                minDistance = minDistance.map { Swift.min($0, distance) } ?? distance
            }
            results[visited][position] = minDistance!
        }
    }
    return results[1 << start][start]!
}
