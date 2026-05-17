// Package mathutil provides integer arithmetic helpers.
package mathutil

// Clamp constrains a value within [lo, hi].
func Clamp[T int | int64 | float64](val, lo, hi T) T {
	if val < lo {
		return lo
	}
	if val > hi {
		return hi
	}
	return val
}

// Abs returns the absolute value of n.
func Abs[T int | int64](n T) T {
	if n < 0 {
		return -n
	}
	return n
}

// GCD computes the greatest common divisor via Euclid's algorithm.
func GCD(a, b uint64) uint64 {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

// Pow computes base raised to exp using exponentiation by squaring.
func Pow(base, exp int64) int64 {
	if exp < 0 {
		return 0
	}
	result := int64(1)
	for exp > 0 {
		if exp&1 == 1 {
			result *= base
		}
		base *= base
		exp >>= 1
	}
	return result
}
