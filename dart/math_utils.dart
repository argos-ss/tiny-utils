library;

/// Clamp a num within [lo, hi].
num clamp(num value, num lo, num hi) {
  if (value < lo) return lo;
  if (value > hi) return hi;
  return value;
}

/// Greatest common divisor (Euclid).
int gcd(int a, int b) {
  while (b != 0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a;
}

/// Least common multiple.
int lcm(int a, int b) => (a ~/ gcd(a, b)) * b;
