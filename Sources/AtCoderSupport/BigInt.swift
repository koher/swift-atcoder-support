import Foundation
struct BigUInt: AdditiveArithmetic, Equatable, Comparable, ExpressibleByIntegerLiteral, CustomStringConvertible {
    typealias Magnitude = BigUInt
    typealias IntegerLiteralType = UInt
    
    private var words: [UInt]
    fileprivate init(words: [UInt]) {
        self.words = words
    }
    init?(_ string: String) {
        self.init(string[...])
    }
    init?(_ string: Substring) {
        if string.isEmpty { return nil }
        if string == "0" {
            self = .zero
            return
        }
        let digitsString: Substring = string
        self = 0
        let zero: UInt32 = UnicodeScalar("0").value
        for c in digitsString.unicodeScalars {
            let digit = UInt(c.value - zero)
            guard (0 ... 9).contains(digit) else { return nil }
            self *= 10
            self += BigUInt(words: [digit])
        }
    }
    init(integerLiteral value: UInt) {
        self.init(value)
    }
    init(_ value: UInt) {
        self.init(words: value == 0 ? [] : [value])
    }
    static var zero: BigUInt { .init(words: []) }
    static func <(lhs: Self, rhs: Self) -> Bool {
        if lhs.words.count < rhs.words.count {
            return true
        } else if lhs.words.count > rhs.words.count {
            return false
        }
        for (l, r) in zip(lhs.words.reversed(), rhs.words.reversed()) {
            if l < r {
                return true
            } else if l > r {
                return false
            }
        }
        return false
    }
    static func +(lhs: Self, rhs: Self) -> Self {
        func plus(_ lhs: BigUInt, _ rhs: BigUInt) -> BigUInt {
            assert(lhs.words.count >= rhs.words.count)
            var words: [UInt] = []
            var carry: UInt = 0
            for (lWord, rWord) in zip(lhs.words, rhs.words) {
                let (word1, overflow1) = lWord.addingReportingOverflow(rWord)
                let (word, overflow2) = word1.addingReportingOverflow(carry)
                words.append(word)
                carry = overflow1 || overflow2 ? 1 : 0
            }
            for lWord in lhs.words[rhs.words.count...] {
                let (word, overflow) = lWord.addingReportingOverflow(carry)
                words.append(word)
                carry = overflow ? 1 : 0
            }
            if carry > 0 {
                words.append(carry)
            }
            return BigUInt(words: words)
        }
        if lhs.words.count < rhs.words.count {
            return plus(rhs, lhs)
        } else {
            return plus(lhs, rhs)
        }
    }
    static func +=(lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
    static func -(lhs: Self, rhs: Self) -> Self {
        precondition(lhs.words.count >= rhs.words.count)
        var words: [UInt] = []
        var borrow: UInt = 0
        for (lWord, rWord) in zip(lhs.words, rhs.words) {
            let (word1, overflow1) = lWord.subtractingReportingOverflow(rWord)
            let (word, overflow2) = word1.subtractingReportingOverflow(borrow)
            words.append(word)
            borrow = overflow1 || overflow2 ? 1 : 0
        }
        for lWord in lhs.words[rhs.words.count...] {
            let (word, overflow) = lWord.subtractingReportingOverflow(borrow)
            words.append(word)
            borrow = overflow ? 1 : 0
        }
        if let lastWord = words.last, lastWord == 0 {
            words.removeLast()
        }
        precondition(borrow == 0)
        return BigUInt(words: words)
    }
    static func -=(lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
    private static func times(_ lhs: Self, _ rhs: UInt, offset: Int) -> Self {
        var words: [UInt] = .init(repeating: 0, count: offset)
        var carry: UInt = 0
        for lWord in lhs.words {
            let (high, low) = lWord.multipliedFullWidth(by: rhs)
            let (word, overflow) = low.addingReportingOverflow(carry)
            words.append(word)
            carry = high + (overflow ? 1 : 0)
        }
        if carry > 0 {
            words.append(carry)
        }
        return BigUInt(words: words)
    }
    static func *(lhs: Self, rhs: Self) -> Self {
        var result: BigUInt = 0
        for (i, rWord) in rhs.words.enumerated() {
            result += times(lhs, rWord, offset: i)
        }
        return result
    }
    static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
//    static func /(lhs: Self, rhs: Self) -> Self {
//        fatalError("Unimplemented yet.")
//    }
//    static func /=(lhs: inout Self, rhs: Self) {
//        lhs = lhs / rhs
//    }
//    static func %(lhs: Self, rhs: Self) -> Self {
//        lhs - lhs / rhs * rhs
//    }
//    static func %=(lhs: inout Self, rhs: Self) {
//        lhs = lhs % rhs
//    }
    func quotientAndRemainder(dividingBy rhs: UInt) -> (quotient: BigUInt, remainder: UInt) {
        var quotientWords: [UInt] = []
        var remainder: UInt = 0
        for word in self.words.reversed() {
            let quotient: UInt
            (quotient, remainder) = rhs.dividingFullWidth((high: remainder, low: word))
            if quotientWords.isEmpty, quotient == 0 { continue }
            quotientWords.append(quotient)
        }
        return (quotient: BigUInt(words: quotientWords.reversed()), remainder: remainder)
    }
    static func /(lhs: Self, rhs: UInt) -> Self {
        let (quotient, _) = lhs.quotientAndRemainder(dividingBy: rhs)
        return quotient
    }
    static func /=(lhs: inout Self, rhs: UInt) {
        lhs = lhs / rhs
    }
    static func %(lhs: Self, rhs: UInt) -> UInt {
        let (_, remainder) = lhs.quotientAndRemainder(dividingBy: rhs)
        return remainder
    }
    static func %=(lhs: inout Self, rhs: UInt) {
        lhs = BigUInt(lhs % rhs)
    }
    static func &(lhs: Self, rhs: Self) -> Self {
        var long: [UInt]
        let short: [UInt]
        if lhs.words.count < rhs.words.count {
            short = lhs.words
            long = rhs.words
        } else {
            short = rhs.words
            long = lhs.words
        }
        for (i, word) in short.enumerated() {
            long[i] &= word
        }
        return BigUInt(words: long)
    }
    static func |(lhs: Self, rhs: Self) -> Self {
        var long: [UInt]
        let short: [UInt]
        if lhs.words.count < rhs.words.count {
            short = lhs.words
            long = rhs.words
        } else {
            short = rhs.words
            long = lhs.words
        }
        for (i, word) in short.enumerated() {
            long[i] |= word
        }
        return BigUInt(words: long)
    }
    static func <<(lhs: Self, rhs: Int) -> Self {
        if rhs < 0 { return lhs >> -rhs }
//        let (wordShift, digitShift) = rhs.quotientAndRemainder(dividingBy: MemoryLayout<UInt>.size)
        fatalError()
    }
    static func <<=(lhs: inout Self, rhs: Int) {
        lhs = lhs << rhs
    }
    static func >>(lhs: Self, rhs: Int) -> Self {
        if rhs < 0 { return lhs << -rhs }
        let (wordShift, bitShift) = rhs.quotientAndRemainder(dividingBy: MemoryLayout<UInt>.size * 8)
        if wordShift >= lhs.words.count { return 0 }
        var words: [UInt] = []
        let maskBitShift = MemoryLayout<UInt>.size * 8 - bitShift
        let mask = UInt.max >> maskBitShift
        var low: UInt?
        for high in lhs.words[wordShift...] {
            if let low = low {
                let word = (low >> bitShift) | ((high & mask) << maskBitShift)
                words.append(word)
            }
            low = high
        }
        if let low = low {
            let word = low >> bitShift
            if word != 0 {
                words.append(word)
            }
        }
        return BigUInt(words: words)
    }
    static func >>=(lhs: inout Self, rhs: Int) {
        lhs = lhs >> rhs
    }
    static func pow(_ lhs: BigUInt, _ rhs: UInt) -> BigUInt {
        var result: BigUInt = 1
        var a = lhs
        var b = rhs
        while true {
            if b & 0x1 != 0 {
                result *= a
            }
            b >>= 1
            guard b > 0 else { break }
            a *= a
        }
        return result
    }
    var description: String {
        if words.isEmpty { return "0" }
        if words.count == 1 { return words[0].description }
        
        var value: BigUInt = self
        var result = ""
        while value > 0 {
            let digit: UInt
            (value, digit) = value.quotientAndRemainder(dividingBy: 10)
            assert(digit.words.count == 1)
            result.append(digit.words[0].description)
        }
        return String(result.reversed())
    }
}
struct BigInt: AdditiveArithmetic, Equatable, Comparable, ExpressibleByIntegerLiteral, CustomStringConvertible {
    fileprivate enum Sign: Equatable {
        case plus
        case minus
        var flipped: Self {
            switch self {
            case .plus: return .minus
            case .minus: return .plus
            }
        }
        var coefficient: Int {
            switch self {
            case .plus: return 1
            case .minus: return -1
            }
        }
    }
    private var sign: Sign
    private var words: BigUInt
    private init(sign: Sign, words: BigUInt) {
        self.sign = sign
        self.words = words
    }
    static var zero: BigInt { .init(sign: .plus, words: .zero) }
    init(_ value: Int) {
        if value > 0 {
            self.init(sign: .plus, words: BigUInt(words: [UInt(value)]))
        } else if value < 0 {
            self.init(sign: .minus, words: BigUInt(words: [UInt(-value)]))
        } else {
            self = .zero
        }
    }
    init?(_ string: String) {
        guard let first = string.first else { return nil }
        let sign: Sign
        let digitsString: Substring
        if first == "-" {
            sign = .minus
            digitsString = string.dropFirst()
        } else {
            sign = .plus
            digitsString = string[...]
        }
        guard let words = BigUInt(digitsString) else { return nil }
        if sign == .minus, words == 0 {
            self.init(sign: .plus, words:words )
        }
        else {
            self.init(sign: sign, words: words)
        }
    }
    init?<S>(_ string: S) where S: StringProtocol {
        self.init(String(string))
    }
    init(integerLiteral value: Int) {
        self.init(value)
    }
    static func <(lhs: BigInt, rhs: BigInt) -> Bool {
        switch (lhs.sign, rhs.sign) {
        case (.plus, .plus): return lhs.words < rhs.words
        case (.plus, .minus): return false
        case (.minus, .plus): return true
        case (.minus, .minus): return lhs.words > rhs.words
        }
    }
    static func +(lhs: BigInt, rhs: BigInt) -> BigInt {
        switch (lhs.sign, rhs.sign) {
        case (.plus, .plus):
            return BigInt(sign: .plus, words: lhs.words + rhs.words)
        case (.plus, .minus):
            if lhs.words < rhs.words {
                return BigInt(sign: .minus, words: rhs.words - lhs.words)
            } else {
                return BigInt(sign: .plus, words: lhs.words - rhs.words)
            }
        case (.minus, .plus):
            if lhs.words < rhs.words {
                return BigInt(sign: .plus, words: rhs.words - lhs.words)
            } else {
                return BigInt(sign: .minus, words: lhs.words - rhs.words)
            }
        case (.minus, .minus): return BigInt(sign: .minus, words: lhs.words + rhs.words)
        }
    }
    static func +=(lhs: inout BigInt, rhs: BigInt) {
        lhs = lhs + rhs
    }
    static func -(lhs: BigInt, rhs: BigInt) -> BigInt {
        lhs + BigInt(sign: rhs.sign.flipped, words: rhs.words)
    }
    static func -=(lhs: inout BigInt, rhs: BigInt) {
        lhs = lhs - rhs
    }
    static func *(lhs: BigInt, rhs: BigInt) -> BigInt {
        let sign: Sign = lhs.sign == rhs.sign ? .plus : .minus
        let words = lhs.words * rhs.words
        return BigInt(sign: sign, words: words)
    }
    static func *=(lhs: inout BigInt, rhs: BigInt) {
        lhs = lhs * rhs
    }
//    static func /(lhs: BigInt, rhs: BigInt) -> BigInt {
//        let sign: Sign = lhs.sign == rhs.sign ? .plus : .minus
//        let words = lhs.words / rhs.words
//        return BigInt(sign: sign, words: words)
//    }
//    static func /=(lhs: inout BigInt, rhs: BigInt) {
//        lhs = lhs / rhs
//    }
//    static func %(lhs: BigInt, rhs: BigInt) -> BigInt {
//        lhs - lhs / rhs * rhs
//    }
//    static func %=(lhs: inout BigInt, rhs: BigInt) {
//        lhs = lhs % rhs
//    }
    func quotientAndRemainder(dividingBy rhs: Int) -> (quotient: BigInt, remainder: Int) {
        let (quotientWords, remainderWords) = words.quotientAndRemainder(dividingBy: UInt(abs(rhs)))
        return (quotient: BigInt(sign: sign, words: quotientWords), remainder: Int(remainderWords) * sign.coefficient)
    }
    static func /(lhs: BigInt, rhs: Int) -> BigInt {
        let (quotient, _) = lhs.quotientAndRemainder(dividingBy: rhs)
        return quotient
    }
    static func /=(lhs: inout BigInt, rhs: Int) {
        lhs = lhs / rhs
    }
    static func %(lhs: BigInt, rhs: Int) -> Int {
        let (_, remainder) = lhs.quotientAndRemainder(dividingBy: rhs)
        return remainder
    }
    static func %=(lhs: inout BigInt, rhs: Int) {
        lhs = BigInt(lhs % rhs)
    }
    static func pow(_ lhs: BigInt, _ rhs: Int) -> BigInt {
        precondition(rhs >= 0)
        let sign: Sign
        switch lhs.sign {
        case .minus: sign = rhs.isMultiple(of: 2) ? .plus : .minus
        case .plus: sign = .plus
        }
        return BigInt(sign: sign, words: .pow(lhs.words, UInt(rhs)))
    }
    static prefix func -(_ value: BigInt) -> BigInt {
        value * -1
    }
    var description: String {
        sign == .minus ? "-" + words.description : words.description
    }
}
private extension Collection {
    func _BigInt_pairs() -> Zip2Sequence<Self, Self.SubSequence> {
        return zip(self, dropFirst())
    }
}
