#if os(Linux)
import Glibc // FIXME: 現状では必要ですが、不要になった段階で除去
#endif
extension BinaryInteger {
    var isPrime: Bool {
        let value = Int(self)
        if value < 2 { return false }
        if value <= 3 { return true }
        if value.isMultiple(of: 2) { return false }
        for n in stride(from: 3, through: Int(Double(value).squareRoot() + 1.5), by: 2) {
            if value.isMultiple(of: n) { return false }
        }
        return true
    }
}
