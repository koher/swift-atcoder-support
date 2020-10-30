func gcd<T>(_ m: T, _ n: T) -> T where T: BinaryInteger {
    precondition(m > 0)
    precondition(n > 0)
    var m = m
    var n = n
    if m < n {
        swap(&m, &n)
    }
    repeat {
        m = m % n
        swap(&m, &n)
    } while n > 0
    return m
}
