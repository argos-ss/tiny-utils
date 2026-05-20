/**
 * String transformation utilities (TypeScript).
 *
 * Pure functions — no side effects, no mutation.
 */

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const NON_WORD = /[^\w\s-]/g;
const SPACES = /[-\s]+/g;
const CAMEL_FIRST = /([A-Z]+)([A-Z][a-z])/g;
const CAMEL_SECOND = /([a-z0-9])([A-Z])/g;

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/** Convert free-form text into a URL-safe slug. */
export function slugify(text: string): string {
  const cleaned = text.toLowerCase().trim().replace(NON_WORD, "");
  return cleaned.replace(SPACES, "-").replace(/^-+|-+$/g, "");
}

/** Truncate text at the nearest word boundary without exceeding maxLength. */
export function truncate(
  text: string,
  maxLength: number = 80,
  suffix: string = "..."
): string {
  if (text.length <= maxLength) return text;

  const candidate = text.slice(0, maxLength);
  const boundary = candidate.lastIndexOf(" ");
  return boundary > 0 ? candidate.slice(0, boundary) + suffix : candidate + suffix;
}

/** Convert camelCase or PascalCase to snake_case. */
export function camelToSnake(name: string): string {
  return name
    .replace(CAMEL_FIRST, "$1_$2")
    .replace(CAMEL_SECOND, "$1_$2")
    .toLowerCase();
}

/** Reverse the order of whitespace-delimited words. */
export function reverseWords(text: string): string {
  return text.split(/\s+/).reverse().join(" ");
}

/** Convert dash-/underscore-delimited text to PascalCase. */
export function toPascal(text: string): string {
  return text
    .split(/[-_]/)
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join("");
}
