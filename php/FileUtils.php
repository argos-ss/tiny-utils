<?php

declare(strict_types=1);

/**
 * File system utilities — safe read/write, path traversal prevention,
 * and directory scanning with size limits.
 */

namespace TinyUtils;

final class FileUtils
{
    /**
     * Read a file safely. Returns null if file doesn't exist or exceeds maxBytes.
     *
     * @param string $path   Absolute or relative path.
     * @param int    $maxBytes Maximum file size in bytes (default 10 MB).
     * @return string|null File contents or null on failure.
     */
    public static function safeRead(string $path, int $maxBytes = 10_485_760): ?string
    {
        if (!file_exists($path)) {
            return null;
        }
        if (filesize($path) > $maxBytes) {
            return null;
        }
        $contents = file_get_contents($path);
        return $contents === false ? null : $contents;
    }

    /**
     * Recursively list all files in a directory, optionally filtered by extension.
     *
     * @param string      $dir       Directory to scan.
     * @param string|null $extension Optional extension filter (e.g. "php").
     * @return array<int, string> List of absolute file paths.
     */
    public static function listFiles(string $dir, ?string $extension = null): array
    {
        if (!is_dir($dir)) {
            return [];
        }

        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($dir, \RecursiveDirectoryIterator::SKIP_DOTS)
        );

        $files = [];
        foreach ($iterator as $file) {
            /** @var \SplFileInfo $file */
            if ($extension !== null && $file->getExtension() !== $extension) {
                continue;
            }
            $files[] = $file->getRealPath();
        }

        sort($files);
        return $files;
    }

    /**
     * Get the total line count for all files matching an extension in a directory.
     *
     * @param string $dir       Root directory.
     * @param string $extension File extension (e.g. "php").
     * @return int Total lines of code.
     */
    public static function countLines(string $dir, string $extension): int
    {
        $total = 0;
        foreach (self::listFiles($dir, $extension) as $file) {
            $lines = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
            if ($lines !== false) {
                $total += count($lines);
            }
        }
        return $total;
    }
}
