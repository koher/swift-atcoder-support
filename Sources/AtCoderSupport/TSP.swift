func tsp<Distance>(distances: [[Distance]], startedAt start: Int) -> Distance where Distance: Comparable, Distance: AdditiveArithmetic {
    precondition(!distances.isEmpty)
    func _tsp(position: Int, visited: Int) -> Distance {
        if visited == (1 << distances.count) - 1 { return distances[position][start] }
        var minDistance: Distance?
        for next in distances.indices {
            if visited & (1 << next) != 0 { continue }
            let distanceToNext: Distance = distances[position][next]
            let distance = distanceToNext + _tsp(position: next, visited: visited | (1 << next))
            minDistance = minDistance.map { Swift.min($0, distance) } ?? distance
        }
        return minDistance!
    }
    return _tsp(position: start, visited: 1 << start)
}
