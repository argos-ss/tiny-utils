/**
 * @file Array utilities — immutable, typed via JSDoc.
 * @module array-utils
 */

/**
 * Split an array into fixed‑size chunks.
 *
 * @template T
 * @param {T[]}  arr
 * @param {number} size  Must be ≥ 1.
 * @returns {Generator<T[]>}
 */
export function* chunk(arr, size) {
  if (size < 1) throw new RangeError(`size must be ≥ 1, got ${size}`);
  for (let i = 0; i < arr.length; i += size) yield arr.slice(i, i + size);
}

/**
 * Fisher‑Yates shuffle (returns a new array).
 *
 * @template T
 * @param {T[]} arr
 * @returns {T[]}
 */
export const shuffle = (arr) => {
  const out = [...arr];
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
};

/**
 * Group array items by a derived key.
 *
 * @template T, K
 * @param {T[]}        arr
 * @param {(item:T) => K} keyFn
 * @returns {Map<K, T[]>}
 */
export const groupBy = (arr, keyFn) => {
  const map = new Map();
  for (const item of arr) {
    const key = keyFn(item);
    if (!map.has(key)) map.set(key, []);
    map.get(key).push(item);
  }
  return map;
};

/**
 * Remove duplicates in O(n) while preserving order.
 *
 * @template T
 * @param {T[]} arr
 * @param {(item:T) => unknown} [keyFn]  Identity function.
 * @returns {T[]}
 */
export const dedupe = (arr, keyFn = (x) => x) => {
  const seen = new Set();
  return arr.filter((item) => {
    const key = keyFn(item);
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
};
export const zip = (...arrays) => {
  const min = Math.min(...arrays.map(a => a.length));
  return Array.from({ length: min }, (_, i) => arrays.map(a => a[i]));
};
export const zip = (...arrays) => {
  const min = Math.min(...arrays.map(a => a.length));
  return Array.from({ length: min }, (_, i) => arrays.map(a => a[i]));
};
export const zip = (...arrays) => {
  const min = Math.min(...arrays.map(a => a.length));
  return Array.from({ length: min }, (_, i) => arrays.map(a => a[i]));
};
