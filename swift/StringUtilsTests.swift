import XCTest

final class StringUtilsTests: XCTestCase {

    // --- slugify ---

    func testSlugifyBasic() {
        XCTAssertEqual(StringUtils.slugify("Hello World!"), "hello-world")
    }

    func testSlugifySpecialChars() {
        XCTAssertEqual(StringUtils.slugify("Hello @#$ World!!!"), "hello-world")
    }

    func testSlugifyMultipleSpaces() {
        XCTAssertEqual(StringUtils.slugify("hello   world"), "hello-world")
    }

    func testSlugifyTrimHyphens() {
        XCTAssertEqual(StringUtils.slugify("-hello world-"), "hello-world")
    }

    func testSlugifyEmpty() {
        XCTAssertEqual(StringUtils.slugify(""), "")
    }

    // --- truncate ---

    func testTruncateNoTruncation() {
        XCTAssertEqual(StringUtils.truncate("hello", maxLen: 10), "hello")
    }

    func testTruncateAtWordBoundary() {
        XCTAssertEqual(StringUtils.truncate("hello world foo", maxLen: 8), "hello...")
    }

    func testTruncateCustomSuffix() {
        XCTAssertEqual(StringUtils.truncate("hello world foo", maxLen: 8, suffix: ".."), "hello..")
    }

    func testTruncateNoWordBoundary() {
        XCTAssertEqual(StringUtils.truncate("abcdefghij", maxLen: 5), "abcde...")
    }

    func testTruncateExactLength() {
        XCTAssertEqual(StringUtils.truncate("hello", maxLen: 5), "hello")
    }

    // --- reverse (top-level function) ---

    func testReverse() {
        XCTAssertEqual(reverse("hello"), "olleh")
    }

    func testReverseEmpty() {
        XCTAssertEqual(reverse(""), "")
    }
}
