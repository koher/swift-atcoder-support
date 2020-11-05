extension Sequence {
    func permutations() -> [[Element]] {
        func _permutations<T>(of values: [T], indices: Range<Int>, result: inout [[T]]) {
            if indices.isEmpty {
                result.append(values)
                return
            }
            var values = values
            for i in indices {
                values.swapAt(indices.lowerBound, i)
                _permutations(of: values, indices: (indices.lowerBound + 1) ..< indices.upperBound, result: &result)
            }
        }
        
        var result: [[Element]] = []
        let values = Array(self)
        _permutations(of: values, indices: values.indices, result: &result)
        return result
    }
}

func npr(_ n: Int, _ r: Int, modulus: Int? = nil) -> Int {
    precondition(n >= 0)
    precondition(r >= 0)
    precondition(n >= r)
    if let modulus = modulus {
        precondition(modulus >= 1)
        return (n - r + 1 ..< n + 1).reduce(into: 1) { $0 = ($0 * $1) % modulus }
    } else {
        return (n - r + 1 ..< n + 1).reduce(into: 1) { $0 *= $1 }
    }
}
