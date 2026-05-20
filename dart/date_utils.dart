/// Date transformation utilities for Dart.
///
/// Pure functions — no side effects, no state.
library tiny_utils.date_utils;

/// Format a [DateTime] as `YYYY-MM-DD`.
String formatDate(DateTime date) => date.toIso8601String().substring(0, 10);

/// Format a [DateTime] as `HH:MM` (24-hour).
String formatTime(DateTime date) =>
    '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

/// Return `true` when both dates fall on the same calendar day.
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Return `true` when [date] is today.
bool isToday(DateTime date) => isSameDay(date, DateTime.now());

/// Return a human-friendly relative description of a [DateTime].
/// Returns "today", "yesterday", "X days ago", or the formatted date.
String relativeDate(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date).inDays;
  if (diff == 0) return 'today';
  if (diff == 1) return 'yesterday';
  if (diff < 7) return '$diff days ago';
  return formatDate(date);
}

/// Return the start of the day (00:00:00.000) for a given [DateTime].
DateTime startOfDay(DateTime date) =>
    DateTime(date.year, date.month, date.day);

/// Return the end of the day (23:59:59.999) for a given [DateTime].
DateTime endOfDay(DateTime date) =>
    DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
