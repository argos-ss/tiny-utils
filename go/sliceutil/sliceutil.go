// Package sliceutil provides generic slice transformation primitives.
package sliceutil

// Chunk splits a slice into chunks of the given size.
// The last chunk may be shorter than size.
func Chunk[T any](items []T, size int) [][]T {
	if size <= 0 {
		return nil
	}
	var chunks [][]T
	for i := 0; i < len(items); i += size {
		end := i + size
		if end > len(items) {
			end = len(items)
		}
		chunks = append(chunks, items[i:end])
	}
	return chunks
}

// Dedupe removes consecutive duplicate elements from a sorted slice.
// For unsorted data, sort first or use DedupeUnordered.
func Dedupe[T comparable](items []T) []T {
	if len(items) == 0 {
		return nil
	}
	result := make([]T, 0, len(items))
	result = append(result, items[0])
	for i := 1; i < len(items); i++ {
		if items[i] != items[i-1] {
			result = append(result, items[i])
		}
	}
	return result
}

// Filter returns a new slice containing only the elements for which
// predicate returns true.
func Filter[T any](items []T, predicate func(T) bool) []T {
	var result []T
	for _, v := range items {
		if predicate(v) {
			result = append(result, v)
		}
	}
	return result
}

// Map applies a transform function to each element of the slice.
func Map[T, U any](items []T, transform func(T) U) []U {
	result := make([]U, len(items))
	for i, v := range items {
		result[i] = transform(v)
	}
	return result
}

// Contains returns true when the slice contains the given item.
func Contains[T comparable](items []T, target T) bool {
	for _, v := range items {
		if v == target {
			return true
		}
	}
	return false
}
