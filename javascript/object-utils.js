/**
 * Object transformation utilities.
 *
 * Pure functions — no mutation of inputs, no side effects.
 * Each function has a single, well-defined responsibility.
 */

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/**
 * Create a deep copy of a plain object or array.
 * Handles nested objects, arrays, Dates, RegExps, Maps, and Sets.
 *
 * @param {*} value - Value to clone.
 * @returns {*} Deep copy of the input.
 */
function deepClone(value) {
  if (value === null || typeof value !== "object") return value;

  if (value instanceof Date) return new Date(value.getTime());
  if (value instanceof RegExp) return new RegExp(value.source, value.flags);
  if (value instanceof Map) {
    const cloned = new Map();
    value.forEach((v, k) => cloned.set(k, deepClone(v)));
    return cloned;
  }
  if (value instanceof Set) {
    return new Set([...value].map(deepClone));
  }

  if (Array.isArray(value)) return value.map(deepClone);

  const result = {};
  for (const key of Object.keys(value)) {
    result[key] = deepClone(value[key]);
  }
  return result;
}

/**
 * Return a new object containing only the specified keys.
 *
 * @param {Object} obj - Source object.
 * @param {string[]} keys - Keys to retain.
 * @returns {Object} Subset of the original.
 */
function pick(obj, keys) {
  const result = {};
  for (const key of keys) {
    if (Object.prototype.hasOwnProperty.call(obj, key)) {
      result[key] = obj[key];
    }
  }
  return result;
}

/**
 * Return a new object excluding the specified keys.
 *
 * @param {Object} obj - Source object.
 * @param {string[]} keys - Keys to omit.
 * @returns {Object} Object without the omitted keys.
 */
function omit(obj, keys) {
  const keySet = new Set(keys);
  const result = {};
  for (const key of Object.keys(obj)) {
    if (!keySet.has(key)) result[key] = obj[key];
  }
  return result;
}

/**
 * Deep-merge two plain objects. Later values overwrite earlier ones.
 *
 * @param {Object} target - Base object.
 * @param {Object} source - Source with overrides / additions.
 * @returns {Object} Merged result (shallow merge of non-plain values).
 */
function deepMerge(target, source) {
  const result = deepClone(target);

  for (const key of Object.keys(source)) {
    const val = source[key];
    if (
      val !== null &&
      typeof val === "object" &&
      !Array.isArray(val) &&
      !(val instanceof Date) &&
      !(val instanceof RegExp) &&
      result[key] !== null &&
      typeof result[key] === "object" &&
      !Array.isArray(result[key])
    ) {
      result[key] = deepMerge(result[key], val);
    } else {
      result[key] = deepClone(val);
    }
  }

  return result;
}

/**
 * Return an array of [key, value] pairs from an object.
 *
 * @param {Object} obj - Source object.
 * @returns {Array<[string, *]>} Entry array.
 */
function entries(obj) {
  return Object.keys(obj).map((key) => [key, obj[key]]);
}

// ---------------------------------------------------------------------------
// Exports
// ---------------------------------------------------------------------------
module.exports = { deepClone, pick, omit, deepMerge, entries };
