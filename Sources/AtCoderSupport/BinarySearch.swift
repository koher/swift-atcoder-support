enum LessThanElement {}
func <(lhs: LessThanElement, rhs: LessThanElement) {}
extension RandomAccessCollection where Element: Comparable, Index == Int {
    func values(_: (LessThanElement, LessThanElement) -> (), _ value: Element) -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if self[mid] < value {
                low = mid
            } else {
                high = mid
            }
        }
        return self[..<high]
    }
}
extension RandomAccessCollection where Index == Int {
    func values(_: (LessThanElement, LessThanElement) -> (), _ predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if try predicate(self[mid]) {
                low = mid
            } else {
                high = mid
            }
        }
        return self[..<high]
    }
}

enum LessThanOrEqualToElement {}
func <=(lhs: LessThanOrEqualToElement, rhs: LessThanOrEqualToElement) {}
extension RandomAccessCollection where Element: Comparable, Index == Int {
    func values(_: (LessThanOrEqualToElement, LessThanOrEqualToElement) -> (), _ value: Element) -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if self[mid] <= value {
                low = mid
            } else {
                high = mid
            }
        }
        return self[..<high]
    }
}
extension RandomAccessCollection where Index == Int {
    func values(_: (LessThanOrEqualToElement, LessThanOrEqualToElement) -> (), _ predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if try predicate(self[mid]) {
                low = mid
            } else {
                high = mid
            }
        }
        return self[..<high]
    }
}

enum GreaterThanElement {}
func >(lhs: GreaterThanElement, rhs: GreaterThanElement) {}
extension RandomAccessCollection where Element: Comparable, Index == Int {
    func values(_: (GreaterThanElement, GreaterThanElement) -> (), _ value: Element) -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if self[mid] > value {
                high = mid
            } else {
                low = mid
            }
        }
        return self[high...]
    }
}
extension RandomAccessCollection where Index == Int {
    func values(_: (GreaterThanElement, GreaterThanElement) -> (), _ predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
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

enum GreaterThanOrEqualToElement {}
func >=(lhs: GreaterThanOrEqualToElement, rhs: GreaterThanOrEqualToElement) {}
extension RandomAccessCollection where Element: Comparable, Index == Int {
    func values(_: (GreaterThanOrEqualToElement, GreaterThanOrEqualToElement) -> (), _ value: Element) -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
        while high - low > 1 {
            let mid = low + (high - low) / 2
            if self[mid] >= value {
                high = mid
            } else {
                low = mid
            }
        }
        return self[high...]
    }
}
extension RandomAccessCollection where Index == Int {
    func values(_: (GreaterThanOrEqualToElement, GreaterThanOrEqualToElement) -> (), _ predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        var low = startIndex - 1
        var high = endIndex
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
