var modulus: Int! // FIXME: 問題に合わせて修正
private var _modulus: Int { modulus }
extension BinaryInteger {
    static var modulus: Self { Self(_modulus) }
}
infix operator %+: AdditionPrecedence
infix operator %-: AdditionPrecedence
infix operator %*: MultiplicationPrecedence
infix operator %/: MultiplicationPrecedence
infix operator %+=: AssignmentPrecedence
infix operator %-=: AssignmentPrecedence
infix operator %*=: AssignmentPrecedence
infix operator %/=: AssignmentPrecedence
extension BinaryInteger {
    static func %+(lhs: Self, rhs: Self) -> Self {
        let r = (lhs + rhs) % modulus
        return r < 0 ? r + modulus : r
    }
    static func %-(lhs: Self, rhs: Self) -> Self {
        let r = (lhs - rhs) % modulus
        return r < 0 ? r + modulus : r
    }
    static func %*(lhs: Self, rhs: Self) -> Self {
        let r = (lhs * rhs) % modulus
        return r < 0 ? r + modulus : r
    }
    static func %/(lhs: Self, rhs: Self) -> Self {
        precondition(lhs >= 0)
        return (lhs * pow(rhs, modulus - 2, modulus: modulus)) % modulus
    }
    static func %+=(lhs: inout Self, rhs: Self) {
        lhs = lhs %+ rhs
    }
    static func %-=(lhs: inout Self, rhs: Self) {
        lhs = lhs %- rhs
    }
    static func %*=(lhs: inout Self, rhs: Self) {
        lhs = lhs %* rhs
    }
    static func %/=(lhs: inout Self, rhs: Self) {
        lhs = lhs %/ rhs
    }
    private static func pow(_ a: Self, _ b: Self, modulus: Self) -> Self {
        var result: Self = .init(1)
        var a = a
        var b = b
        while true {
            if b & 0x1 != .zero {
                result = (result * a) % modulus
            }
            b >>= 1
            guard b > .zero else { break }
            a = (a * a) % modulus
        }
        return result
    }
}
extension UnsignedInteger {
    static func %-(lhs: Self, rhs: Self) -> Self {
        if lhs < rhs {
            return modulus - (rhs - lhs) % modulus
        } else {
            return (lhs - rhs) % modulus
        }
    }
    static func %-=(lhs: inout Self, rhs: Self) {
        lhs = lhs %- rhs
    }
}
