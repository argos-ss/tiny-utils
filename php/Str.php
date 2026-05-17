<?php
declare(strict_types=1);

namespace TinyUtils;

final class Str {
    public static function slugify(string $text): string {
        $s = mb_strtolower(trim($text));
        $s = preg_replace('/[^\w\s-]/u', '', $s);
        $s = preg_replace('/[-\s]+/u', '-', $s);
        return trim($s, '-');
    }

    public static function truncate(string $text, int $maxLen = 80, string $suffix = '...'): string {
        if (mb_strlen($text) <= $maxLen) return $text;
        $truncated = mb_substr($text, 0, $maxLen);
        $lastSpace = mb_strrpos($truncated, ' ');
        return ($lastSpace !== false ? mb_substr($truncated, 0, $lastSpace) : $truncated) . $suffix;
    }
}
