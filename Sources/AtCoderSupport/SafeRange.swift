infix operator ..<?: RangeFormationPrecedence
func ..<?<T>(lhs: T, rhs: T) -> Range<T>? where T: Comparable {
    guard lhs <= rhs else { return nil }
    return lhs ..< rhs
}

infix operator ...?: RangeFormationPrecedence
func ...?<T>(lhs: T, rhs: T) -> ClosedRange<T>? where T: Comparable {
    guard lhs <= rhs else { return nil }
    return lhs ... rhs
}
