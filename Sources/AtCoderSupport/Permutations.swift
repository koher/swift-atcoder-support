func permutations<C>(of values: C) -> [[C.Element]]
        where C: RandomAccessCollection, C.SubSequence: RangeReplaceableCollection,
              C.Indices == Range<Int>, C.SubSequence.Indices == Range<Int> {
    var result: [[C.Element]] = []
    _permutations(of: Array(values), indices: values.indices, result: &result)
    return result
}

private func _permutations<T>(of values: [T], indices: Range<Int>, result: inout [[T]]) {
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
