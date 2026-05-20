import 'package:test/test.dart';
import 'date_utils.dart';

void main() {
  group('formatDate', () {
    test('formats as YYYY-MM-DD', () {
      final d = DateTime(2024, 1, 15);
      expect(formatDate(d), equals('2024-01-15'));
    });
  });

  group('formatTime', () {
    test('formats as HH:MM', () {
      final d = DateTime(2024, 1, 1, 14, 5);
      expect(formatTime(d), equals('14:05'));
    });

    test('pads single digit hours', () {
      final d = DateTime(2024, 1, 1, 9, 30);
      expect(formatTime(d), equals('09:30'));
    });
  });

  group('isSameDay', () {
    test('same day returns true', () {
      final a = DateTime(2024, 1, 1, 10, 0);
      final b = DateTime(2024, 1, 1, 15, 30);
      expect(isSameDay(a, b), isTrue);
    });

    test('different day returns false', () {
      final a = DateTime(2024, 1, 1);
      final b = DateTime(2024, 1, 2);
      expect(isSameDay(a, b), isFalse);
    });
  });

  group('isToday', () {
    test('returns true for today', () {
      expect(isToday(DateTime.now()), isTrue);
    });

    test('returns false for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(isToday(yesterday), isFalse);
    });
  });

  group('relativeDate', () {
    test('returns today', () {
      expect(relativeDate(DateTime.now()), equals('today'));
    });

    test('returns yesterday', () {
      final d = DateTime.now().subtract(const Duration(days: 1));
      expect(relativeDate(d), equals('yesterday'));
    });

    test('returns days ago for < 7 days', () {
      final d = DateTime.now().subtract(const Duration(days: 3));
      expect(relativeDate(d), equals('3 days ago'));
    });
  });

  group('startOfDay / endOfDay', () {
    test('startOfDay resets time components', () {
      final d = DateTime(2024, 6, 15, 14, 30, 45, 123);
      final start = startOfDay(d);
      expect(start.hour, equals(0));
      expect(start.minute, equals(0));
      expect(start.second, equals(0));
      expect(start.millisecond, equals(0));
    });

    test('endOfDay sets time to 23:59:59.999', () {
      final d = DateTime(2024, 6, 15);
      final end = endOfDay(d);
      expect(end.hour, equals(23));
      expect(end.minute, equals(59));
      expect(end.second, equals(59));
      expect(end.millisecond, equals(999));
    });
  });
}
