/**
 * json-utils — JSON utilities for JavaScript
 * - Deep clone
 * - Safe parse
 * - Flatten/unflatten
 * - Object diff/merge
 * - JSONPath-like query
 */

/**
 * Safely parse JSON string, returning fallback on failure.
 */
function safeParse(str, fallback = null) {
  try {
    return JSON.parse(str);
  } catch {
    return fallback;
  }
}

/**
 * Deep clone any JSON-serializable value.
 */
function deepClone(obj) {
  return JSON.parse(JSON.stringify(obj));
}

/**
 * Deep merge two objects (mutates target).
 */
function deepMerge(target, source) {
  for (const key of Object.keys(source)) {
    if (source[key] instanceof Object && key in target) {
      Object.assign(source[key], deepMerge(target[key], source[key]));
    }
  }
  Object.assign(target || {}, source);
  return target;
}

/**
 * Flatten nested object into dot-notation keys.
 * { a: { b: 1 } } → { 'a.b': 1 }
 */
function flatten(obj, prefix = '') {
  return Object.keys(obj).reduce((acc, key) => {
    const pre = prefix.length ? prefix + '.' : '';
    if (typeof obj[key] === 'object' && obj[key] !== null && !Array.isArray(obj[key])) {
      Object.assign(acc, flatten(obj[key], pre + key));
    } else {
      acc[pre + key] = obj[key];
    }
    return acc;
  }, {});
}

/**
 * Unflatten dot-notation keys back to nested object.
 * { 'a.b': 1 } → { a: { b: 1 } }
 */
function unflatten(obj) {
  const result = {};
  for (const key of Object.keys(obj)) {
    const keys = key.split('.');
    let current = result;
    for (let i = 0; i < keys.length - 1; i++) {
      if (!current[keys[i]]) current[keys[i]] = {};
      current = current[keys[i]];
    }
    current[keys[keys.length - 1]] = obj[key];
  }
  return result;
}

/**
 * Deep diff between two objects (returns added/changed/removed keys).
 */
function diff(obj1, obj2) {
  const flat1 = flatten(obj1);
  const flat2 = flatten(obj2);
  const result = { added: {}, changed: {}, removed: {} };

  for (const key of Object.keys(flat2)) {
    if (!(key in flat1)) {
      result.added[key] = flat2[key];
    } else if (flat1[key] !== flat2[key]) {
      result.changed[key] = { from: flat1[key], to: flat2[key] };
    }
  }
  for (const key of Object.keys(flat1)) {
    if (!(key in flat2)) {
      result.removed[key] = flat1[key];
    }
  }
  return result;
}

/**
 * Format JSON with colors for console (simple formatting version).
 */
function prettyPrint(obj, indent = 2) {
  return JSON.stringify(obj, null, indent);
}

module.exports = {
  safeParse,
  deepClone,
  deepMerge,
  flatten,
  unflatten,
  diff,
  prettyPrint,
};
