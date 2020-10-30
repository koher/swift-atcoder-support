#if os(Linux)
import Glibc // FIXME: 現状では必要ですが、不要になった段階で除去
#endif
extension BinaryInteger where Stride: SignedInteger {
    func divisors() -> [Self] {
        precondition(self > 0)
        if self == 1 { return [1] }
        var result: [Self] = []
        let sqrtn = Self(Double(self).squareRoot())
        for i in 1 ... sqrtn {
            if self.isMultiple(of: i) {
                result.append(i)
                result.append(self / i)
            }
        }
        if sqrtn * sqrtn == self {
            result.removeLast()
        }
        result.sort()
        return result
    }
}
