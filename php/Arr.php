<?php
/**
 * Array transformation utilities (PHP).
 *
 * Pure functions — no side effects, no mutation of inputs.
 * Each function has a single, well-defined responsibility.
 */

declare(strict_types=1);

class Arr
{
    /**
     * Retrieve a value from a nested array using dot notation.
     *
     * @param array<string, mixed> $array Source array.
     * @param string               $key   Dot-separated key path.
     * @param mixed                $default Fallback when key is missing.
     * @return mixed
     *
     * @example Arr::get(['user' => ['name' => 'Alice']], 'user.name') → 'Alice'
     */
    public static function get(array $array, string $key, mixed $default = null): mixed
    {
        $segments = explode('.', $key);
        $current = $array;

        foreach ($segments as $segment) {
            if (!is_array($current) || !array_key_exists($segment, $current)) {
                return $default;
            }
            $current = $current[$segment];
        }

        return $current;
    }

    /**
     * Pluck a column of values from an array of associative arrays.
     *
     * @param array<array<string, mixed>> $array Source data.
     * @param string                      $key   Column key.
     * @return array<int, mixed>
     */
    public static function pluck(array $array, string $key): array
    {
        $result = [];
        foreach ($array as $item) {
            if (is_array($item) && array_key_exists($key, $item)) {
                $result[] = $item[$key];
            }
        }
        return $result;
    }

    /**
     * Split an array into chunks of the given size.
     *
     * @param array $array Source array.
     * @param int   $size  Chunk size (must be > 0).
     * @return array<int, array>
     */
    public static function chunk(array $array, int $size): array
    {
        if ($size <= 0) {
            return [];
        }
        return array_chunk($array, $size);
    }

    /**
     * Flatten a multi-dimensional array one level deep.
     *
     * @param array $array Nested array.
     * @return array<int, mixed>
     */
    public static function flatten(array $array): array
    {
        $result = [];
        array_walk_recursive($array, function ($value) use (&$result): void {
            $result[] = $value;
        });
        return $result;
    }

    /**
     * Return an associative array keyed by the given column.
     *
     * @param array<array<string, mixed>> $array Source data.
     * @param string                      $key   Column to use as key.
     * @return array<string, array<string, mixed>>
     */
    public static function keyBy(array $array, string $key): array
    {
        $result = [];
        foreach ($array as $item) {
            if (is_array($item) && array_key_exists($key, $item)) {
                $result[(string)$item[$key]] = $item;
            }
        }
        return $result;
    }
}
