infix operator **

//fileprivate let mod = 1000000007
fileprivate let mod = 998244353

struct Zn: CustomStringConvertible, AdditiveArithmetic, Hashable, ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    let n: Int
    init(_ n: Int) { self.n = n }
    init(safe n: Int) { let m = n % mod; if m >= 0 { self.n = m } else { self.n = m + mod } }
    init(integerLiteral value: IntegerLiteralType) { n = value }
    var description: String { String(n) }
    static var zero = Zn(0)
    static var one = Zn(1)
    static prefix func - (value: Self) -> Self { Zn(value.n == 0 ? 0 : mod - value.n) }
    static func + (lhs: Self, rhs: Self) -> Self { let n = lhs.n + rhs.n; return Zn(n < mod ? n : n - mod) }
    static func + (lhs: Self, rhs: Int) -> Self { lhs + Zn(rhs) }
    static func + (lhs: Int, rhs: Self) -> Self { Zn(lhs) + rhs }
    static func - (lhs: Self, rhs: Self) -> Self { let n = lhs.n - rhs.n; return Zn(n >= 0 ? n : n + mod) }
    static func - (lhs: Self, rhs: Int) -> Self { lhs - Zn(rhs) }
    static func - (lhs: Int, rhs: Self) -> Self { Zn(lhs) - rhs }
    static func * (lhs: Self, rhs: Self) -> Self { Zn((lhs.n * rhs.n) % mod) }
    static func * (lhs: Self, rhs: Int) -> Self { lhs * Zn(rhs) }
    static func * (lhs: Int, rhs: Self) -> Self { Zn(lhs) * rhs }
    static func / (lhs: Self, rhs: Self) -> Self { lhs * rhs.inverse }
    static func / (lhs: Int, rhs: Self) -> Self { Zn(lhs) * rhs.inverse }
    static func / (lhs: Self, rhs: Int) -> Self { lhs * Zn(rhs).inverse }
    static func += (lhs: inout Self, rhs: Self) { lhs = lhs + rhs }
    static func += (lhs: inout Self, rhs: Int) { lhs = lhs + Zn(rhs) }
    static func -= (lhs: inout Self, rhs: Self) { lhs = lhs - rhs }
    static func -= (lhs: inout Self, rhs: Int) { lhs = lhs - Zn(rhs) }
    static func *= (lhs: inout Self, rhs: Self) { lhs = lhs * rhs }
    static func *= (lhs: inout Self, rhs: Int) { lhs = lhs * Zn(rhs) }
    static func /= (lhs: inout Self, rhs: Self) { lhs = lhs / rhs }
    static func /= (lhs: inout Self, rhs: Int) { lhs = lhs / Zn(rhs) }
    static func ** (lhs: Self, rhs: Int) -> Self { lhs.pow(rhs) }

    func pow(_ n: Int) -> Self {
        if n < 0 { return inverse.pow(-n) }
        var result: Zn = 1
        var x: Zn = self
        var n = n
        while n > 0 {
            if n & 1 == 1 { result *= x }
            x *= x
            n >>= 1
        }
        return result
    }
    var inverse: Self { pow(mod - 2) }
}
