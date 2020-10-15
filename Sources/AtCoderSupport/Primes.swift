func primes(upTo number: Int) -> [Int] {
    precondition(number >= 0)
    if number < 2 { return [] }
    var result: [Int] = []
    var sieve: [Bool] = .init(repeating: false, count: number + 1)
    for m in 2 ... number {
        if sieve[m] { continue }
        result.append(m)
        for k in stride(from: m * 2, through: number, by: m) {
            sieve[k] = true
        }
    }
    return result
}
