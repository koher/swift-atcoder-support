func permutations<C>(of values: C) -> [[C.Element]] where C: RandomAccessCollection, C.Indices == Range<Int>, C.SubSequence: RangeReplaceableCollection, C.SubSequence.Indices == Range<Int> {
    if values.isEmpty { return [[]] }
    if values.count == 1 { return [[values[0]]] }
    if values.count == 2 { return [[values[1], values[0]], [values[0], values[1]]] }
    if values.count == 3 { return [
        [values[2], values[1], values[0]],
        [values[2], values[0], values[1]],
        [values[1], values[2], values[0]],
        [values[1], values[0], values[2]],
        [values[0], values[2], values[1]],
        [values[0], values[1], values[2]],
    ] }
    if values.count == 4 { return [
        [values[3], values[2], values[1], values[0]],
        [values[3], values[2], values[0], values[1]],
        [values[3], values[1], values[2], values[0]],
        [values[3], values[1], values[0], values[2]],
        [values[3], values[0], values[2], values[1]],
        [values[3], values[0], values[1], values[2]],
        [values[2], values[3], values[1], values[0]],
        [values[2], values[3], values[0], values[1]],
        [values[2], values[1], values[3], values[0]],
        [values[2], values[1], values[0], values[3]],
        [values[2], values[0], values[3], values[1]],
        [values[2], values[0], values[1], values[3]],
        [values[1], values[3], values[2], values[0]],
        [values[1], values[3], values[0], values[2]],
        [values[1], values[2], values[3], values[0]],
        [values[1], values[2], values[0], values[3]],
        [values[1], values[0], values[3], values[2]],
        [values[1], values[0], values[2], values[3]],
        [values[0], values[3], values[2], values[1]],
        [values[0], values[3], values[1], values[2]],
        [values[0], values[2], values[3], values[1]],
        [values[0], values[2], values[1], values[3]],
        [values[0], values[1], values[3], values[2]],
        [values[0], values[1], values[2], values[3]],
    ] }
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
