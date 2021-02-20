extension RandomAccessCollection where Element: Comparable, Index == Int {
    func values(_ op: (Element, Element) -> Bool, _ value: Element) -> SubSequence {
        if self.isEmpty { return self[...] }
        if self.count == 1 {
            if op(self.first!, value) {
                return self[...]
            } else {
                return self[startIndex ..< startIndex]
            }
        }
        let isLess = op(self.first!, self.last!)
        let op = isLess ? op : { !op($0, $1) }
        
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if op(self[mid], value) {
                low = mid
            } else {
                high = mid
            }
        }
        if isLess {
            return self[..<high]
        } else {
            return self[high...]
        }
    }
}
