/// String manipulation utilities.
///
/// Every function is a top-level pure function — no state, no side effects.
library;

/// URL‑safe slug from free-form text.
String slugify(String text) {
  final s = text.toLowerCase().trim();
  return s
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .replaceAll(RegExp(r'[-\s]+'), '-')
      .replaceAll(RegExp(r'^-+|-+\$'), '');
}

/// Truncate text at the nearest word boundary.
String truncate(String text, {int maxLen = 80, String suffix = '...'}) {
  if (text.length <= maxLen) return text;
  final truncated = text.substring(0, maxLen);
  final lastSpace = truncated.lastIndexOf(' ');
  return (lastSpace > 0 ? truncated.substring(0, lastSpace) : truncated) + suffix;
}

/// Count occurrences of a substring.
int countOccurrences(String text, String pattern) {
  int count = 0;
  int i = 0;
  while ((i = text.indexOf(pattern, i)) != -1) {
    count++;
    i += pattern.length;
  }
  return count;
}
