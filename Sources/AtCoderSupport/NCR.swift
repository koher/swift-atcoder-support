struct NCR {
    let maxN: Int
    let modulus: Int
    private let factorials: [Int]
    private let inverses: [Int]
    private let inverseFactorials: [Int]
    
    init(maxN: Int, modulus: Int) {
        precondition(maxN >= 0)
        precondition(modulus >= 2)
        var factorials: [Int] = [1, 1]
        var inverses: [Int] = [1, 1]
        var inverseFactorials: [Int] = [1, 1]
        factorials.reserveCapacity(maxN + 1)
        inverses.reserveCapacity(maxN + 1)
        inverseFactorials.reserveCapacity(maxN + 1)
        if maxN >= 2 {
            for i in 2 ... maxN {
                factorials.append(factorials[i - 1] * i % modulus)
                inverses.append(modulus - inverses[modulus % i] * (modulus / i) % modulus)
                inverseFactorials.append(inverseFactorials[i - 1] * inverses[i] % modulus)
            }
        }
        
        self.maxN = maxN
        self.modulus = modulus
        self.factorials = factorials
        self.inverses = inverses
        self.inverseFactorials = inverseFactorials
    }
    
    func factorial(of n: Int) -> Int {
        precondition(n >= 0)
        precondition(n <= maxN)
        return factorials[n]
    }
    
    func npr(_ n: Int, _ r: Int) -> Int {
        precondition(n >= 0)
        precondition(n <= maxN)
        precondition(r >= 0)
        precondition(r <= n)
        return factorials[n] * inverseFactorials[n - r] % modulus
    }
    
    func ncr(_ n: Int, _ r: Int) -> Int {
        precondition(n >= 0)
        precondition(n <= maxN)
        precondition(r >= 0)
        precondition(r <= n)
        return factorials[n] * (inverseFactorials[n - r] * inverseFactorials[r] % modulus) % modulus
    }
    
    func callAsFunction(_ n: Int, _ r: Int) -> Int {
        ncr(n, r)
    }
}

