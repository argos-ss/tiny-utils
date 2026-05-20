/**
 * Math transformation utilities (TypeScript).
 *
 * Pure functions — no side effects, no mutation.
 */

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/** Clamp a value between a lower and upper bound (inclusive). */
export function clamp(value: number, low: number, high: number): number {
  return value < low ? low : value > high ? high : value;
}

/** Linear interpolation between a and b by t [0..1]. */
export function lerp(a: number, b: number, t: number): number {
  return a + (b - a) * clamp(t, 0, 1);
}

/** Round a number to a specified number of decimal places. */
export function roundTo(value: number, decimals: number = 0): number {
  const factor = 10 ** decimals;
  return Math.round(value * factor) / factor;
}

/** Calculate the percentage that `part` represents of `total`. */
export function percentage(part: number, total: number): number {
  if (total === 0) return 0;
  return roundTo((part / total) * 100, 2);
}

/** Return the arithmetic mean of an array of numbers. */
export function average(values: number[]): number {
  if (values.length === 0) return 0;
  return values.reduce((sum, v) => sum + v, 0) / values.length;
}

/** Return the median of an array of numbers. */
export function median(values: number[]): number {
  if (values.length === 0) return 0;
  const sorted = [...values].sort((a, b) => a - b);
  const mid = Math.floor(sorted.length / 2);
  return sorted.length % 2 !== 0
    ? sorted[mid]
    : (sorted[mid - 1] + sorted[mid]) / 2;
}
