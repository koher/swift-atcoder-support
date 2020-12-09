import Foundation
struct BigInt: AdditiveArithmetic, ExpressibleByIntegerLiteral, CustomStringConvertible {
    private var decimal: Decimal
    private init(_ decimal: Decimal) {
        self.decimal = decimal
    }
    init(_ value: Int) {
        decimal = .init(value)
    }
    init?(_ string: String) {
        guard let decimal = Decimal(string: string, locale: Locale(identifier: "en")) else { return nil }
        self.init(decimal)
    }
    init(integerLiteral value: Int) {
        self.init(value)
    }
    static func +(lhs: BigInt, rhs: BigInt) -> BigInt {
        BigInt(lhs.decimal + rhs.decimal)
    }
    static func -(lhs: BigInt, rhs: BigInt) -> BigInt {
        BigInt(lhs.decimal - rhs.decimal)
    }
    static func *(lhs: BigInt, rhs: BigInt) -> BigInt {
        BigInt(lhs.decimal * rhs.decimal)
    }
    static func /(lhs: BigInt, rhs: BigInt) -> BigInt {
        BigInt((lhs.decimal / rhs.decimal).roundToZero)
    }
    static func %(lhs: BigInt, rhs: BigInt) -> BigInt {
        BigInt(lhs.decimal - (lhs.decimal / rhs.decimal).roundToZero * rhs.decimal)
    }
    static func pow(_ lhs: BigInt, _ rhs: Int) -> BigInt {
        BigInt(Foundation.pow(lhs.decimal, rhs))
    }
    static prefix func -(_ value: BigInt) -> BigInt {
        value * -1
    }
    var description: String {
        decimal.description
    }
}
private extension Decimal {
    var roundToZero: Decimal {
        let handler: NSDecimalNumberHandler
        if self < 0 {
            handler = NSDecimalNumberHandler(roundingMode: .up, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        } else {
            handler = NSDecimalNumberHandler(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        }
        return ((self as NSDecimalNumber).rounding(accordingToBehavior: handler) as Decimal)
    }
}
