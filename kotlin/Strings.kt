package com.tinyutils

/**
 * String transformation utilities for Kotlin.
 *
 * Extension functions — clean, idiomatic, pure.
 */

/**
 * Convert free-form text into a URL-safe slug.
 *
 * Example: "Hello World!" → "hello-world"
 */
fun String.slugify(): String {
    return this.lowercase()
        .trim()
        .replace(Regex("[^\\w\\s-]"), "")
        .replace(Regex("[\\s-]+"), "-")
        .trim('-')
}

/**
 * Truncate text at the nearest word boundary without exceeding maxLength.
 */
fun String.truncate(maxLength: Int = 80, suffix: String = "..."): String {
    if (this.length <= maxLength) return this

    val candidate = this.take(maxLength)
    val boundary = candidate.lastIndexOf(' ')
    return if (boundary > 0) candidate.take(boundary) + suffix else candidate + suffix
}

/**
 * Convert camelCase or PascalCase to snake_case.
 */
fun String.camelToSnake(): String {
    return this
        .replace(Regex("([A-Z]+)([A-Z][a-z])"), "$1_$2")
        .replace(Regex("([a-z0-9])([A-Z])"), "$1_$2")
        .lowercase()
}

/**
 * Reverse the order of whitespace-delimited words.
 */
fun String.reverseWords(): String {
    return this.split(Regex("\\s+")).reversed().joinToString(" ")
}

/**
 * Convert dash-/underscore-delimited text to PascalCase.
 */
fun String.toPascal(): String {
    return this.split(Regex("[-_]"))
        .joinToString("") { it.replaceFirstChar(Char::uppercase) }
}
