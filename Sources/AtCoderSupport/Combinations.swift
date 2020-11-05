func ncr(_ n: Int, _ r: Int, modulus: Int? = nil) -> Int {
    precondition(n >= 0)
    precondition(r >= 0)
    precondition(n >= r)
    if let modulus = modulus {
        precondition(modulus >= 1)
        func npr(_ n: Int, _ r: Int, modulus: Int) -> Int {
            (n - r + 1 ..< n + 1).reduce(into: 1) { $0 = ($0 * $1) % modulus }
        }
        func pow(_ a: Int, _ b: Int, modulus: Int) -> Int {
            var result = 1
            var a = a
            var b = b
            while true {
                if b & 0x1 != 0 {
                    result = (result * a) % modulus
                }
                b >>= 1
                guard b > 0 else { break }
                a *= a
            }
            return result
        }
        let numerator = npr(n, r, modulus: modulus)
        let denominator = npr(r, r, modulus: modulus)
        return (numerator * pow(denominator, modulus - 2, modulus: modulus)) % modulus
    } else {
        return (1 ..< r + 1).reduce(into: 1) { $0 = $0 * (n - $1 + 1) / $1 }
    }
}
