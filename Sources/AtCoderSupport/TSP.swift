func tsp<Distance>(distances: [[Distance]], startedAt start: Int) -> Distance where Distance: Comparable, Distance: AdditiveArithmetic {
    precondition(!distances.isEmpty)
    var tspResults: [[Distance?]] = distances.indices.map { _ in [Distance?](repeating: nil, count: 1 << distances.count) }
    func _tsp(position: Int, visited: Int) -> Distance {
        if let result = tspResults[position][visited] { return result }
        if visited == (1 << distances.count) - 1 {
            let result = distances[position][start]
            tspResults[position][visited] = result
            return result
        }
        var minDistance: Distance?
        for next in distances.indices {
            if visited & (1 << next) != 0 { continue }
            let distanceToNext: Distance = distances[position][next]
            let distance = distanceToNext + _tsp(position: next, visited: visited | (1 << next))
            minDistance = minDistance.map { Swift.min($0, distance) } ?? distance
        }
        let result =  minDistance!
        tspResults[position][visited] = result
        return result
    }
    return _tsp(position: start, visited: 1 << start)
}
