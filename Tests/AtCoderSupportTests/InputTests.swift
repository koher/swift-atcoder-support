import XCTest
@testable import AtCoderSupport

final class InputTest: XCTestCase {
    func testInput() {
        #if TEST_INPUT
        // 標準入力のテストを実行する場合は TEST_INPUT フラグを立て
        // Tests/Input に記載された内容を標準入力に渡して下さい。
        do {
            let r = readInt1()
            XCTAssertEqual(r, 2)
        }
        
        do {
            let (r1, r2) = readInt2()
            XCTAssertEqual(r1, 3)
            XCTAssertEqual(r2, 5)
        }
        
        do {
            let (r1, r2, r3) = readInt3()
            XCTAssertEqual(r1, 7)
            XCTAssertEqual(r2, 11)
            XCTAssertEqual(r3, 13)
        }
        
        do {
            let (r1, r2, r3, r4) = readInt4()
            XCTAssertEqual(r1, 17)
            XCTAssertEqual(r2, 19)
            XCTAssertEqual(r3, 23)
            XCTAssertEqual(r4, 29)
        }

        do {
            let r = readIntN()
            XCTAssertEqual(r, [31, 37, 41, 43, 47])
        }
        #endif
    }
}
