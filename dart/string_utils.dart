String slugify(String text) {
  final s = text.toLowerCase().trim();
  return s
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .replaceAll(RegExp(r'[-\s]+'), '-')
      .replaceAll(RegExp(r'^-+|-+\$'), '');
}

String truncate(String text, {int maxLen = 80, String suffix = '...'}) {
  if (text.length <= maxLen) return text;
  final truncated = text.substring(0, maxLen);
  final lastSpace = truncated.lastIndexOf(' ');
  return (lastSpace > 0 ? truncated.substring(0, lastSpace) : truncated) + suffix;
}
