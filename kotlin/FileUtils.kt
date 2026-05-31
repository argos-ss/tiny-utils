package com.tinyutils

import java.io.File
import java.nio.file.Path
import java.nio.file.Paths
import java.security.DigestInputStream
import java.security.MessageDigest

/**
 * File-system utility functions for Kotlin.
 *
 * Pure, side-effect-free helpers (except [hashFile] which reads a file).
 */

/**
 * List all files recursively under a directory matching the given extension.
 */
fun File.listByExtension(extension: String): List<File> {
    require(isDirectory) { "$this must be a directory" }
    return walkTopDown()
        .filter { it.isFile && it.extension == extension.trimStart('.') }
        .toList()
}

/**
 * Calculate the relative path of a child from a parent directory.
 */
fun File.relativeTo(parent: File): String {
    return toPath().relativize(parent.toPath()).toString()
}

/**
 * Normalize path separators to the system default.
 */
fun String.normalizePath(): String {
    return Paths.get(this).normalize().toString()
}

/**
 * Compute the SHA-256 hex digest of a file.
 * Can be expensive for large files — use sparingly.
 */
fun File.sha256Hex(): String {
    val digest = MessageDigest.getInstance("SHA-256")
    val buffer = ByteArray(8192)
    inputStream().buffered().use { input ->
        DigestInputStream(input, digest).use { dis ->
            while (dis.read(buffer) != -1) { /* consume stream */ }
        }
    }
    return digest.digest().joinToString("") { "%02x".format(it) }
}

/**
 * Human-readable byte count (e.g., "2.4 MB").
 */
fun Long.toHumanSize(): String {
    val units = arrayOf("B", "KB", "MB", "GB", "TB")
    var size = this.toDouble()
    var unitIdx = 0
    while (size >= 1024.0 && unitIdx < units.lastIndex) {
        size /= 1024.0
        unitIdx++
    }
    return "%.1f %s".format(size, units[unitIdx])
}

/**
 * Check if a filename is safe for cross-platform use (no reserved chars).
 */
fun String.isSafeFilename(): Boolean {
    val reserved = setOf('<', '>', ':', '"', '/', '\\', '|', '?', '*')
    return isNotBlank() && none { it in reserved } && length <= 255
}
