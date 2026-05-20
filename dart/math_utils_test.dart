import 'package:test/test.dart';
import 'math_utils.dart';

void main() {
  group('clamp', () {
    test('value within range', () {
      expect(clamp(5, 0, 10), equals(5));
    });
    test('below range', () {
      expect(clamp(-1, 0, 10), equals(0));
    });
    test('above range', () {
      expect(clamp(15, 0, 10), equals(10));
    });
    test('equal bounds', () {
      expect(clamp(5, 5, 5), equals(5));
    });
  });

  group('gcd', () {
    test('basic gcd', () {
      expect(gcd(12, 8), equals(4));
    });
    test('coprime numbers', () {
      expect(gcd(17, 5), equals(1));
    });
    test('with zero', () {
      expect(gcd(0, 5), equals(5));
    });
  });

  group('lcm', () {
    test('basic lcm', () {
      expect(lcm(4, 6), equals(12));
    });
    test('when one divides other', () {
      expect(lcm(3, 9), equals(9));
    });
    test('with coprime', () {
      expect(lcm(3, 5), equals(15));
    });
  });
}
