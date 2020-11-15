func + <T: AdditiveArithmetic>(lhs: (T, T), rhs: (T, T)) -> (T, T) {
    (lhs.0 + rhs.0, lhs.1 + rhs.1)
}
func += <T: AdditiveArithmetic>(lhs: inout (T, T), rhs: (T, T)) {
    lhs = lhs + rhs
}
func - <T: AdditiveArithmetic>(lhs: (T, T), rhs: (T, T)) -> (T, T) {
    (lhs.0 - rhs.0, lhs.1 - rhs.1)
}
func -= <T: AdditiveArithmetic>(lhs: inout (T, T), rhs: (T, T)) {
    lhs = lhs - rhs
}
func * <T: Numeric>(lhs: (T, T), rhs: T) -> (T, T) {
    (lhs.0 * rhs, lhs.1 * rhs)
}
func *= <T: Numeric>(lhs: inout (T, T), rhs: T) {
    lhs = lhs * rhs
}
func / <T: BinaryInteger>(lhs: (T, T), rhs: T) -> (T, T) {
    (lhs.0 / rhs, lhs.1 / rhs)
}
func /= <T: BinaryInteger>(lhs: inout (T, T), rhs: T) {
    lhs = lhs / rhs
}
func / <T: FloatingPoint>(lhs: (T, T), rhs: T) -> (T, T) {
    (lhs.0 / rhs, lhs.1 / rhs)
}
func /= <T: FloatingPoint>(lhs: inout (T, T), rhs: T) {
    lhs = lhs / rhs
}
prefix func - <T: SignedNumeric>(operand: (T, T)) -> (T, T) {
    (-operand.0, -operand.1)
}
