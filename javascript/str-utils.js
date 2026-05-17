/**
 * @file String utilities — every function is a pure expression.
 * @module str-utils
 */

/** Regex cache for slugify. */
const WORD_CLEAN = /[^\w\s-]/g;

/** @param {string} text */
export const slugify = (text) =>
  text
    .toLowerCase()
    .trim()
    .replace(WORD_CLEAN, "")
    .replace(/[-\s]+/g, "-")
    .replace(/^-+|-+$/g, "");

/**
 * Truncate at word boundary.
 *
 * @param {string}  text
 * @param {number}  [maxLen=80]
 * @param {string}  [suffix='...']
 * @returns {string}
 */
export const truncate = (text, maxLen = 80, suffix = "...") => {
  if (text.length <= maxLen) return text;
  const partial = text.slice(0, maxLen);
  const last = partial.lastIndexOf(" ");
  return (last > 0 ? partial.slice(0, last) : partial) + suffix;
};

/**
 * Reverse the order of words.
 *
 * @param {string} text
 * @returns {string}
 */
export const reverseWords = (text) => text.split(/\s+/).reverse().join(" ");

/**
 * Escape special regex characters in a string.
 *
 * @param {string} text
 * @returns {string} Regex‑safe literal.
 */
export const escapeRegex = (text) =>
  text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
