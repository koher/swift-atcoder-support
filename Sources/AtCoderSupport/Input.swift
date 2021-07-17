func readInt1() -> Int {
    Int(readLine()!)!
}

func readInt2() -> (Int, Int) {
    let values = readLine()!.split(separator: " ").map { Int(String($0))! }
    precondition(values.count == 2)
    return (values[0], values[1])
}

func readInt3(line: Int = #line, file: String = #file) -> (Int, Int, Int) {
    let values = readLine()!.split(separator: " ").map { Int(String($0))! }
    precondition(values.count == 3)
    return (values[0], values[1], values[2])
}

func readInt4(line: Int = #line, file: String = #file) -> (Int, Int, Int, Int) {
    let values = readLine()!.split(separator: " ").map { Int(String($0))! }
    precondition(values.count == 4)
    return (values[0], values[1], values[2], values[3])
}

func readIntN(line: Int = #line, file: String = #file) -> [Int] {
    readLine()!.split(separator: " ").map { Int(String($0))! }
}
