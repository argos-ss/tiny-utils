package sliceutil

import "testing"

func TestChunk(t *testing.T) {
	tests := []struct {
		items []int
		size  int
		want  [][]int
	}{
		{[]int{1, 2, 3, 4, 5}, 2, [][]int{{1, 2}, {3, 4}, {5}}},
		{[]int{1, 2, 3, 4}, 2, [][]int{{1, 2}, {3, 4}}},
		{[]int{1, 2}, 10, [][]int{{1, 2}}},
		{[]int{}, 3, nil},
		{[]int{1, 2}, 0, nil},
	}
	for _, tt := range tests {
		got := Chunk(tt.items, tt.size)
		if !slicesEqual2D(got, tt.want) {
			t.Errorf("Chunk(%v,%d) = %v, want %v", tt.items, tt.size, got, tt.want)
		}
	}
}

func TestDedupe(t *testing.T) {
	tests := []struct {
		items []int
		want  []int
	}{
		{[]int{1, 1, 2, 3, 3, 3, 4}, []int{1, 2, 3, 4}},
		{[]int{1, 2, 3}, []int{1, 2, 3}},
		{[]int{}, nil},
	}
	for _, tt := range tests {
		got := Dedupe(tt.items)
		if !slicesEqual(got, tt.want) {
			t.Errorf("Dedupe(%v) = %v, want %v", tt.items, got, tt.want)
		}
	}
}

func TestFilter(t *testing.T) {
	items := []int{1, 2, 3, 4, 5}
	got := Filter(items, func(v int) bool { return v > 3 })
	want := []int{4, 5}
	if !slicesEqual(got, want) {
		t.Errorf("Filter(%v) = %v, want %v", items, got, want)
	}
}

func TestMap(t *testing.T) {
	items := []int{1, 2, 3}
	got := Map(items, func(v int) int { return v * 2 })
	want := []int{2, 4, 6}
	if !slicesEqual(got, want) {
		t.Errorf("Map(%v) = %v, want %v", items, got, want)
	}
}

func TestContains(t *testing.T) {
	items := []int{1, 2, 3, 4, 5}
	if !Contains(items, 3) {
		t.Error("Contains should find 3")
	}
	if Contains(items, 99) {
		t.Error("Contains should not find 99")
	}
	if Contains([]int{}, 1) {
		t.Error("Contains empty should return false")
	}
}

// Helpers

func slicesEqual(a, b []int) bool {
	if len(a) != len(b) {
		return false
	}
	for i := range a {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

func slicesEqual2D(a, b [][]int) bool {
	if len(a) != len(b) {
		return false
	}
	for i := range a {
		if !slicesEqual(a[i], b[i]) {
			return false
		}
	}
	return true
}
