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
        self.init(words: [1])
        let zero: UInt32 = UnicodeScalar("0").value
        for c in digitsString.unicodeScalars {
            let digit = UInt(c.value - zero)
            self *= BigUInt(words: [digit])
        }
    }
    init(integerLiteral value: UInt) {
        self.words = [value]
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
        func plus(l: BigUInt, r: BigUInt) -> BigUInt {
            assert(lhs.words.count >= rhs.words.count)
            var words: [UInt] = []
            var carry: UInt = 0
            for (lWord, rWord) in zip(l.words, r.words) {
                let word = lWord &+ rWord &+ carry
                words.append(word)
                carry = word > lWord ? 0 : word == lWord ? carry : 1
            }
            for lWord in l.words[r.words.count...] {
                let word = lWord &+ carry
                words.append(word)
                carry = word > lWord ? 0 : 1
            }
            if carry > 0 {
                words.append(carry)
            }
            return BigUInt(words: words)
        }
        if lhs.words.count < rhs.words.count {
            return plus(l: rhs, r: lhs)
        } else {
            return plus(l: lhs, r: rhs)
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
            let word = lWord &- rWord &- borrow
            words.append(word)
            borrow = word < lWord ? 0 : word == lWord ? borrow : 1
        }
        for lWord in lhs.words[rhs.words.count...] {
            let word = lWord &- borrow
            words.append(word)
            borrow = word < lWord ? 0 : 1
        }
        precondition(borrow == 0)
        return BigUInt(words: words)
    }
    static func -=(lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
    static func *(lhs: Self, rhs: Self) -> Self {
        fatalError()
    }
    static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    static func /(lhs: Self, rhs: Self) -> Self {
        fatalError()
    }
    static func /=(lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
    static func %(lhs: Self, rhs: Self) -> Self {
        lhs - lhs / rhs * rhs
    }
    static func %=(lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }
    var description: String {
        if self == 0 { return "0" }
        
        var value: BigUInt = self
        var result = ""
        while value > 0 {
            let digit = value % 10
            assert(digit.words.count == 1)
            result.append(digit.words[0].description)
            value /= 10
        }
        return result
    }
}
struct BigInt: AdditiveArithmetic, Equatable, Comparable, ExpressibleByIntegerLiteral, CustomStringConvertible {
    private enum Sign: Equatable {
        case plus
        case minus
        var flipped: Self {
            switch self {
            case .plus: return .minus
            case .minus: return .plus
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
        self.init(sign: sign, words: words)
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
    static func /(lhs: BigInt, rhs: BigInt) -> BigInt {
        let sign: Sign = lhs.sign == rhs.sign ? .plus : .minus
        let words = lhs.words / rhs.words
        return BigInt(sign: sign, words: words)
    }
    static func /=(lhs: inout BigInt, rhs: BigInt) {
        lhs = lhs / rhs
    }
    static func %(lhs: BigInt, rhs: BigInt) -> BigInt {
        lhs - lhs / rhs * rhs
    }
    static func %=(lhs: inout BigInt, rhs: BigInt) {
        lhs = lhs % rhs
    }
    static func pow(_ lhs: BigInt, _ rhs: BigInt) -> BigInt {
        fatalError()
    }
    static prefix func -(_ value: BigInt) -> BigInt {
        value * -1
    }
    var description: String {
        sign == .minus ? "-" + words.description : words.description
    }
}
