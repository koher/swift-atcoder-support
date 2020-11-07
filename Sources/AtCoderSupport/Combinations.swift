func ncr<Integer>(_ n: Integer, _ r: Integer, modulus: Integer? = nil) -> Integer where Integer: BinaryInteger, Integer.Stride: SignedInteger {
    precondition(n >= 0)
    precondition(r >= 0)
    precondition(n >= r)
    if let modulus = modulus {
        precondition(modulus >= 1)
        func npr(_ n: Integer, _ r: Integer, modulus: Integer) -> Integer {
            (n - r + 1 ..< n + 1).reduce(into: 1) { $0 = ($0 * $1) % modulus }
        }
        func pow(_ a: Integer, _ b: Integer, modulus: Integer) -> Integer {
            var result: Integer = .init(1)
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
        let numerator = npr(n, r, modulus: modulus)
        let denominator = npr(r, r, modulus: modulus)
        return (numerator * pow(denominator, modulus - 2, modulus: modulus)) % modulus
    } else {
        return (1 ..< r + 1).reduce(into: 1 as Integer) { $0 = $0 * (n - $1 + 1) / $1 }
    }
}
