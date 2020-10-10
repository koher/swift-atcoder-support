import XCTest
@testable import AtCoderSupport

final class InputTest: XCTestCase {
    func testInput() {
        #if TEST_INPUT
        // 標準入力のテストを実行する場合は TEST_INPUT フラグを立て
        // Tests/Input に記載された内容を標準入力に渡して下さい。
        do {
            let r = int1()
            XCTAssertEqual(r, 2)
        }
        
        do {
            let (r1, r2) = int2()
            XCTAssertEqual(r1, 3)
            XCTAssertEqual(r2, 5)
        }
        
        do {
            let (r1, r2, r3) = int3()
            XCTAssertEqual(r1, 7)
            XCTAssertEqual(r2, 11)
            XCTAssertEqual(r3, 13)
        }

        do {
            let r = intN()
            XCTAssertEqual(r, [17, 19, 23, 29])
        }
        #endif
    }
}
