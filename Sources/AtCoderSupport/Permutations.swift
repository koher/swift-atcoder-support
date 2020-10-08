func permutations<S: Sequence>(of values: S) -> [[S.Element]] {
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
    
    var result: [[S.Element]] = []
    let values = Array(values)
    _permutations(of: values, indices: values.indices, result: &result)
    return result
}
