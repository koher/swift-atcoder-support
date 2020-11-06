func pow<Integer>(_ a: Integer, _ b: Integer, modulus: Integer? = nil) -> Integer where Integer: BinaryInteger {
    var result: Integer = 1
    var a = a
    var b = b
    if let modulus = modulus {
        while true {
            if b & 0x1 != 0 {
                result = (result * a) % modulus
            }
            b >>= 1
            guard b > 0 else { break }
            a = (a * a) % modulus
        }
    } else {
        while true {
            if b & 0x1 != 0 {
                result *= a
            }
            b >>= 1
            guard b > 0 else { break }
            a *= a
        }
    }
    return result
}
