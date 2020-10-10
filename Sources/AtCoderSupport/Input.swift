func int1(line: Int = #line, file: String = #file) -> Int {
    guard let string = readLine() else {
        preconditionFailure("No input (at line \(line) in \(file))")
    }
    guard let value = Int(string) else {
        preconditionFailure("Illegal input value: \(string) (at line \(line) in \(file))")
    }
    return value
}

func int2(line: Int = #line, file: String = #file) -> (Int, Int) {
    guard let string = readLine() else {
        preconditionFailure("No input (at line \(line) in \(file))")
    }
    let values: [Int] = string.split(separator: " ").map { part in
        guard let value = Int(part) else {
            preconditionFailure("Illegal input value: \(string) (at line \(line) in \(file))")
        }
        return value
    }
    precondition(values.count == 2, "Illegal number of input values: count = \(values.count), values = \(values) (at line \(line) in \(file))")
    return (values[0], values[1])
}

func int3(line: Int = #line, file: String = #file) -> (Int, Int, Int) {
    guard let string = readLine() else {
        preconditionFailure("No input (at line \(line) in \(file))")
    }
    let values: [Int] = string.split(separator: " ").map { part in
        guard let value = Int(part) else {
            preconditionFailure("Illegal input value: \(string) (at line \(line) in \(file))")
        }
        return value
    }
    precondition(values.count == 3, "Illegal number of input values: count = \(values.count), values = \(values) (at line \(line) in \(file))")
    return (values[0], values[1], values[2])
}

func intN(line: Int = #line, file: String = #file) -> [Int] {
    guard let string = readLine() else {
        preconditionFailure("No input (at line \(line) in \(file))")
    }
    let values: [Int] = string.split(separator: " ").map { part in
        guard let value = Int(part) else {
            preconditionFailure("Illegal input value: \(string) (at line \(line) in \(file))")
        }
        return value
    }
    return values
}
