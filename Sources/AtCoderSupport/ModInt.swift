let modulus: UInt = 998244353 // FIXME: 問題に合わせて修正
struct ModInt: AdditiveArithmetic, ExpressibleByIntegerLiteral, CustomStringConvertible, Hashable {
    let value: UInt
    init(_ value: UInt) {
        self.value = value % modulus
    }
    init(_ value: Int) {
        if value < 0 {
            self.init(UInt(value % Int(modulus) + Int(modulus)))
        } else {
            self.init(UInt(value))
        }
    }
    init(integerLiteral value: Int) {
        self.init(value)
    }
    static func +(lhs: Self, rhs: Self) -> Self {
        let r = lhs.value + rhs.value
        if r < modulus {
            return Self(r)
        } else {
            return Self(r - modulus)
        }
    }
    static func -(lhs: Self, rhs: Self) -> Self {
        if lhs.value < rhs.value {
            return Self(lhs.value + modulus - rhs.value)
        } else {
            return Self(lhs.value - rhs.value)
        }
    }
    static func *(lhs: Self, rhs: Self) -> Self {
        Self((lhs.value * rhs.value) % modulus)
    }
    static func +=(lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
    static func -=(lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
    static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    var description: String { value.description }
}
