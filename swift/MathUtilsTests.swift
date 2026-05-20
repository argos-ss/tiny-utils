import XCTest

final class MathUtilsTests: XCTestCase {

    // --- clamp ---

    func testClampInRange() {
        XCTAssertEqual(clamp(5, low: 0, high: 10), 5)
    }

    func testClampBelow() {
        XCTAssertEqual(clamp(-1, low: 0, high: 10), 0)
    }

    func testClampAbove() {
        XCTAssertEqual(clamp(15, low: 0, high: 10), 10)
    }

    func testClampEqualBounds() {
        XCTAssertEqual(clamp(5, low: 5, high: 5), 5)
    }

    // --- lerp ---

    func testLerpStart() {
        XCTAssertEqual(lerp(10, 20, 0), 10, accuracy: 0.001)
    }

    func testLerpEnd() {
        XCTAssertEqual(lerp(10, 20, 1), 20, accuracy: 0.001)
    }

    func testLerpMid() {
        XCTAssertEqual(lerp(10, 20, 0.5), 15, accuracy: 0.001)
    }

    // --- roundTo ---

    func testRoundToDefault() {
        XCTAssertEqual(roundTo(3.7), 4, accuracy: 0.001)
    }

    func testRoundToDecimals() {
        XCTAssertEqual(roundTo(3.14159, 2), 3.14, accuracy: 0.001)
    }

    // --- percentage ---

    func testPercentageBasic() {
        XCTAssertEqual(percentage(25, of: 100), 25, accuracy: 0.01)
    }

    func testPercentageZeroTotal() {
        XCTAssertEqual(percentage(10, of: 0), 0, accuracy: 0.001)
    }

    // --- average ---

    func testAverage() {
        XCTAssertEqual(average([1, 2, 3, 4, 5]), 3, accuracy: 0.001)
    }

    func testAverageEmpty() {
        XCTAssertEqual(average([]), 0, accuracy: 0.001)
    }

    // --- MathUtils struct ---

    func testStructClamp() {
        XCTAssertEqual(MathUtils.clamp(5, low: 0, high: 10), 5)
    }

    func testStructAverage() {
        XCTAssertEqual(MathUtils.average([1, 2, 3, 4, 5]), 3, accuracy: 0.001)
    }
}
