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

extension RandomAccessCollection where Index == Int {
    func values(_ op: (Int, Int) -> Bool, _ predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        let isLess = op(1, 2)
        
        var low = startIndex - 1
        var high = endIndex
        if isLess {
            while high - low > 1 {
                let mid = low + (high - low) / 2
                if try predicate(self[mid]) {
                    low = mid
                } else {
                    high = mid
                }
            }
            return self[..<high]
        } else {
            while high - low > 1 {
                let mid = low + (high - low) / 2
                if try predicate(self[mid]) {
                    high = mid
                } else {
                    low = mid
                }
            }
            return self[high...]
        }
    }
}
