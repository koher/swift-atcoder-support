func primes(upTo number: Int) -> [Int] {
    precondition(number >= 0)
    if number < 2 { return [] }
    var sieve: [Bool] = .init(repeating: false, count: number + 1)
    for m in stride(from: 3, through: Int(Double(number).squareRoot() + 1.5), by: 2) {
        if sieve[m] { continue }
        let maxK = number / m
        if maxK < 2 { continue }
        for k in 2 ... maxK {
            sieve[k * m] = true
        }
    }
    var result: [Int] = [2]
    for m in stride(from: 3, through: number, by: 2) {
        if sieve[m] { continue }
        result.append(m)
    }
    return result
}
