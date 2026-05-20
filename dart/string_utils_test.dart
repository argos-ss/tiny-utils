import 'package:test/test.dart';
import 'string_utils.dart';

void main() {
  group('slugify', () {
    test('converts to lowercase slug', () {
      expect(slugify('Hello World!'), equals('hello-world'));
    });
    test('removes special characters', () {
      expect(slugify('Hello @#$ World!!!'), equals('hello-world'));
    });
    test('handles multiple spaces', () {
      expect(slugify('hello   world'), equals('hello-world'));
    });
    test('trims hyphens', () {
      expect(slugify('-hello world-'), equals('hello-world'));
    });
    test('empty string', () {
      expect(slugify(''), equals(''));
    });
  });

  group('truncate', () {
    test('no truncation needed', () {
      expect(truncate('hello', maxLen: 10), equals('hello'));
    });
    test('truncates at word boundary', () {
      expect(truncate('hello world foo', maxLen: 8), equals('hello...'));
    });
    test('custom suffix', () {
      expect(truncate('hello world foo', maxLen: 8, suffix: '..'), equals('hello..'));
    });
    test('no word boundary', () {
      expect(truncate('abcdefghij', maxLen: 5), equals('abcde...'));
    });
    test('exact length', () {
      expect(truncate('hello', maxLen: 5), equals('hello'));
    });
  });
}
