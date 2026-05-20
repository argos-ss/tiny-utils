package mathutil

import "testing"

func TestClampInt(t *testing.T) {
	tests := []struct {
		val, lo, hi, want int
	}{
		{5, 0, 10, 5},
		{-1, 0, 10, 0},
		{15, 0, 10, 10},
		{5, 5, 5, 5},
	}
	for _, tt := range tests {
		got := Clamp(tt.val, tt.lo, tt.hi)
		if got != tt.want {
			t.Errorf("Clamp(%d,%d,%d) = %d, want %d", tt.val, tt.lo, tt.hi, got, tt.want)
		}
	}
}

func TestClampFloat64(t *testing.T) {
	got := Clamp(3.5, 0.0, 10.0)
	if got != 3.5 {
		t.Errorf("Clamp(float64) = %f, want 3.5", got)
	}
}

func TestAbs(t *testing.T) {
	tests := []struct {
		n    int
		want int
	}{
		{5, 5},
		{-5, 5},
		{0, 0},
	}
	for _, tt := range tests {
		got := Abs(tt.n)
		if got != tt.want {
			t.Errorf("Abs(%d) = %d, want %d", tt.n, got, tt.want)
		}
	}
}

func TestGCD(t *testing.T) {
	tests := []struct {
		a, b, want uint64
	}{
		{12, 8, 4},
		{17, 5, 1},
		{0, 5, 5},
		{100, 25, 25},
	}
	for _, tt := range tests {
		got := GCD(tt.a, tt.b)
		if got != tt.want {
			t.Errorf("GCD(%d,%d) = %d, want %d", tt.a, tt.b, got, tt.want)
		}
	}
}

func TestPow(t *testing.T) {
	tests := []struct {
		base, exp, want int64
	}{
		{2, 10, 1024},
		{2, 0, 1},
		{3, 3, 27},
		{10, 1, 10},
		{2, -1, 0},
	}
	for _, tt := range tests {
		got := Pow(tt.base, tt.exp)
		if got != tt.want {
			t.Errorf("Pow(%d,%d) = %d, want %d", tt.base, tt.exp, got, tt.want)
		}
	}
}
