func tsp<Distance>(distances: [[Distance]], startedAt start: Int) -> Distance where Distance: Comparable, Distance: AdditiveArithmetic {
    precondition(!distances.isEmpty)
    var results: [Distance?] = .init(repeating: nil, count: (1 << distances.count) * distances.count)
    for position in distances.indices {
        results[((1 << distances.count) - 1) * distances.count + position] = distances[position][start]
    }
    for visited in (0 ..< (1 << distances.count) - 1).reversed() {
        if visited & (1 << start) == 0 { continue }
        for position in distances.indices {
            var minDistance: Distance?
            if visited & (1 << position) == 0 { continue }
            for next in distances.indices {
                if visited & (1 << next) != 0 { continue }
                let distanceToNext: Distance = distances[position][next]
                let distance = distanceToNext + results[(visited | (1 << next)) * distances.count + next]!
                minDistance = minDistance.map { Swift.min($0, distance) } ?? distance
            }
            results[visited * distances.count + position] = minDistance!
        }
    }
    return results[(1 << start) * distances.count + start]!
}
