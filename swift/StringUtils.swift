/// String transformation primitives — all pure, no side effects.
///
/// Usage:
/// ```swift
/// import StringUtils
/// StringUtils.slugify("Hello World!") // "hello-world"
/// ```

public enum StringUtils {

    private static let nonWord = try! NSRegularExpression(pattern: "[^\\w\\s-]")
    private static let spaces  = try! NSRegularExpression(pattern: "[-\\s]+")

    /// URL‑safe slug from free text.
    public static func slugify(_ text: String) -> String {
        var s = text.lowercased().trimmingCharacters(in: .whitespaces)
        s = nonWord.stringByReplacingMatches(in: s, range: NSRange(location: 0, length: s.utf16.count), withTemplate: "")
        s = spaces.stringByReplacingMatches(in: s, range: NSRange(location: 0, length: s.utf16.count), withTemplate: "-")
        return s.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }

    /// Truncate string at word boundary.
    public static func truncate(_ text: String, maxLen: Int = 80, suffix: String = "...") -> String {
        guard text.count > maxLen else { return text }
        let endIndex = text.index(text.startIndex, offsetBy: maxLen)
        let truncated = text[..<endIndex]
        if let lastSpace = truncated.lastIndex(of: " ") {
            return String(text[..<lastSpace]) + suffix
        }
        return String(truncated) + suffix
    }
}
