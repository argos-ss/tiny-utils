/**
 * File and path utility functions.
 * @module file-utils
 */

/**
 * Extract file extension from a filename.
 * @param {string} filename
 * @returns {string} Extension without dot, or empty string.
 */
export function extname(filename) {
  const idx = filename.lastIndexOf('.');
  return idx > 0 ? filename.slice(idx + 1) : '';
}

/**
 * Check if a filename matches a given glob-like extension pattern.
 * @param {string} filename
 * @param {string} ext - e.g. ".js", ".ts"
 * @returns {boolean}
 */
export function hasExtension(filename, ext) {
  return filename.toLowerCase().endsWith(ext.toLowerCase());
}

/**
 * Human-readable file size.
 * @param {number} bytes
 * @param {number} [decimals=1]
 * @returns {string}
 */
export function formatSize(bytes, decimals = 1) {
  if (bytes === 0) return '0 B';
  const units = ['B', 'KB', 'MB', 'GB', 'TB'];
  const k = 1024;
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(decimals)) + ' ' + units[i];
}

/**
 * Sanitize a filename by removing unsafe characters.
 * @param {string} name
 * @param {string} [replacement='_']
 * @returns {string}
 */
export function sanitizeFilename(name, replacement = '_') {
  return name.replace(/[<>:"/\\|?*]/g, replacement).trim();
}

/**
 * Get the base name without extension.
 * @param {string} filename
 * @returns {string}
 */
export function basename(filename) {
  const name = filename.split('/').pop().split('\\').pop();
  const idx = name.lastIndexOf('.');
  return idx > 0 ? name.slice(0, idx) : name;
}

export default { extname, hasExtension, formatSize, sanitizeFilename, basename };
