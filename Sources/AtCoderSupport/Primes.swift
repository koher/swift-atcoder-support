func primes(upTo number: Int) -> [Int] {
    precondition(number >= 0)
    if number < 2 { return [] }
    var sieve: [Bool] = .init(repeating: false, count: number + 1)
    for m in stride(from: 3, through: Int(Double(number).squareRoot() + 1.5), by: 2) {
        if sieve[m] { continue }
        for k in stride(from: m * 2, through: number, by: m) {
            sieve[k] = true
        }
    }
    var result: [Int] = [2]
    for m in stride(from: 3, through: number, by: 2) {
        if sieve[m] { continue }
        result.append(m)
    }
    return result
}
