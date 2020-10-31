extension ClosedRange where Bound: BinaryInteger {
    func sum(modulus: Bound? = nil) -> Bound {
        let result = (lowerBound + upperBound) * (upperBound - lowerBound + 1) / 2
        guard let modulus = modulus else { return result }
        if result < 0 {
            return result % modulus + modulus
        } else {
            return result % modulus
        }
    }
}
