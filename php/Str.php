<?php

declare(strict_types=1);

namespace TinyUtils;

/**
 * Immutable string helpers — every method is static and pure.
 */
final class Str
{
    /** URL‑safe slug. */
    public static function slugify(string $text): string
    {
        $s = mb_strtolower(trim($text));
        $s = preg_replace('/[^\w\s-]/u', '', $s);
        $s = preg_replace('/[-\s]+/u', '-', $s);
        return trim($s, '-');
    }

    /** Truncate at word boundary. */
    public static function truncate(string $text, int $maxLen = 80, string $suffix = '...'): string
    {
        if (mb_strlen($text) <= $maxLen) {
            return $text;
        }
        $truncated = mb_substr($text, 0, $maxLen);
        $lastSpace = mb_strrpos($truncated, ' ');
        return ($lastSpace !== false ? mb_substr($truncated, 0, $lastSpace) : $truncated) . $suffix;
    }

    /** Check if string starts with a given substring. */
    public static function startsWith(string $haystack, string $needle): bool
    {
        return str_starts_with($haystack, $needle);
    }

    /** Check if string ends with a given substring. */
    public static function endsWith(string $haystack, string $needle): bool
    {
        return str_ends_with($haystack, $needle);
    }
}
