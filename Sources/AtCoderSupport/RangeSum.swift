extension ClosedRange where Bound: BinaryInteger {
    func sum(modulus: Bound? = nil) -> Bound {
        let n: Bound = upperBound - lowerBound + 1
        let result = (lowerBound + upperBound) * n / 2
        guard let modulus = modulus else { return result }
        if result < 0 {
            return result % modulus + modulus
        } else {
            return result % modulus
        }
    }
}
