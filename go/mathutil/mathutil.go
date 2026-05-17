package mathutil

func Min(a, b int) int {
	if a < b { return a }
	return b
}

func Max(a, b int) int {
	if a > b { return a }
	return b
}

func Clamp(val, min, max int) int {
	if val < min { return min }
	if val > max { return max }
	return val
}

func Abs(n int) int {
	if n < 0 { return -n }
	return n
}

// Pow computes integer power.
func Pow(base, exp int) int {
	result := 1
	for i := 0; i < exp; i++ {
		result *= base
	}
	return result
}
