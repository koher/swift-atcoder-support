func permutations<C>(of values: C) -> [[C.Element]]
        where C: RandomAccessCollection, C.SubSequence: RangeReplaceableCollection,
              C.Indices == Range<Int>, C.SubSequence.Indices == Range<Int> {
    if values.isEmpty { return [[]] }
    var result: [[C.Element]] = []
    for i in values.indices {
        var subresult = permutations(of: values[..<i] + values[(i + 1)...])
        for j in subresult.indices {
            subresult[j].append(values[i])
        }
        result.append(contentsOf: subresult)
    }
    return result
}
