infix operator +?: AdditionPrecedence
extension FixedWidthInteger {
    static func +? (lhs: Self, rhs: Self) -> Self? {
        let (result, overflows) = lhs.addingReportingOverflow(rhs)
        if overflows { return nil }
        return result
    }
}

infix operator -?: AdditionPrecedence
extension FixedWidthInteger {
    static func -? (lhs: Self, rhs: Self) -> Self? {
        let (result, overflows) = lhs.subtractingReportingOverflow(rhs)
        if overflows { return nil }
        return result
    }
}

infix operator *?: MultiplicationPrecedence
extension FixedWidthInteger {
    static func *? (lhs: Self, rhs: Self) -> Self? {
        let (result, overflows) = lhs.multipliedReportingOverflow(by: rhs)
        if overflows { return nil }
        return result
    }
}
