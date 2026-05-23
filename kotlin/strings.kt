/**
 * strings — basic string and text utilities for Kotlin
 */

/**
 * Check if string is null or blank.
 */
fun isBlank(s: String?): Boolean = s.isNullOrBlank()

/**
 * Truncate string to max length with optional suffix.
 */
fun truncate(s: String, maxLen: Int, suffix: String = "..."): String {
    return if (s.length <= maxLen) s
    else s.take(maxLen - suffix.length) + suffix
}

/**
 * Count word occurrences in a string.
 */
fun wordCount(s: String): Map<String, Int> {
    return s.lowercase()
        .split(Regex("\\W+"))
        .filter { it.isNotBlank() }
        .groupingBy { it }
        .eachCount()
}

/**
 * Slugify a string (URL-safe version).
 */
fun slugify(s: String): String {
    return s.lowercase()
        .replace(Regex("[^a-z0-9\\s-]"), "")
        .replace(Regex("[\\s-]+"), "-")
        .trim('-')
}

/**
 * Mask part of a string (e.g. email, credit card).
 */
fun mask(s: String, visibleChars: Int = 4, maskChar: Char = '*'): String {
    if (s.length <= visibleChars) return s
    return maskChar.toString().repeat(s.length - visibleChars) + s.takeLast(visibleChars)
}

/**
 * Parse camelCase to readable words.
 */
fun camelToWords(s: String): String {
    return s.replace(Regex("([a-z])([A-Z])"), "$1 $2")
        .replaceFirstChar { it.uppercase() }
}

/**
 * Check if string is a valid email (basic check).
 */
fun isValidEmail(s: String): Boolean {
    return Regex("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$").matches(s)
}

fun main() {
    println("isBlank test: ${isBlank(" ")}")       // true
    println("truncate: ${truncate("Hello World!", 8)}")  // Hello...
    println("slugify: ${slugify("Hello World! Kotlin")}") // hello-world-kotlin
    println("mask: ${mask("test@email.com")}")      // ********.com
    println("camelToWords: ${camelToWords("helloWorldTest")}") // Hello World Test
    println("isValidEmail: ${isValidEmail("test@test.com")}")  // true
}
