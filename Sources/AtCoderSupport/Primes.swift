func primes(upTo number: Int) -> [Int] {
    precondition(number >= 0)
    if number < 2 { return [] }
    var sieve: [Bool] = .init(repeating: false, count: number + 1)
    for m in 2 ... Int(Double(number).squareRoot() + 1.5) {
        if sieve[m] { continue }
        for k in stride(from: m * 2, through: number, by: m) {
            sieve[k] = true
        }
    }
    return (2 ... number).filter { !sieve[$0] }
}
