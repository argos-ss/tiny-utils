/// Collection transformation utilities for Rust.
///
/// All functions are pure and work with standard `Vec<T>`.

// ---------------------------------------------------------------------------
// Chunk
// ---------------------------------------------------------------------------

/// Split a vector into chunks of the given size.
///
/// The last chunk may be shorter than `size`.
pub fn chunk<T: Clone>(items: &[T], size: usize) -> Vec<Vec<T>> {
    if size == 0 {
        return Vec::new();
    }
    items.chunks(size).map(|c| c.to_vec()).collect()
}

// ---------------------------------------------------------------------------
// Dedupe
// ---------------------------------------------------------------------------

/// Remove consecutive duplicate elements from a sorted slice.
pub fn dedupe<T: Clone + PartialEq>(items: &[T]) -> Vec<T> {
    if items.is_empty() {
        return Vec::new();
    }
    let mut result = Vec::with_capacity(items.len());
    result.push(items[0].clone());
    for i in 1..items.len() {
        if items[i] != items[i - 1] {
            result.push(items[i].clone());
        }
    }
    result
}

// ---------------------------------------------------------------------------
// Filter
// ---------------------------------------------------------------------------

/// Return a new vector containing only elements for which the predicate
/// returns `true`.
pub fn filter<T: Clone>(items: &[T], predicate: fn(&T) -> bool) -> Vec<T> {
    items.iter().filter(|&v| predicate(v)).cloned().collect()
}

// ---------------------------------------------------------------------------
// Map
// ---------------------------------------------------------------------------

/// Apply a transform function to each element of the slice.
pub fn map_vec<T: Clone, U>(items: &[T], transform: fn(&T) -> U) -> Vec<U> {
    items.iter().map(transform).collect()
}

// ---------------------------------------------------------------------------
// GroupBy
// ---------------------------------------------------------------------------

/// Group elements into a `Vec<(String, Vec<T>)>` by a string key function.
pub fn group_by<T: Clone>(items: &[T], key_fn: fn(&T) -> String) -> Vec<(String, Vec<T>)> {
    use std::collections::HashMap;
    let mut map: HashMap<String, Vec<T>> = HashMap::new();
    for item in items {
        let key = key_fn(item);
        map.entry(key).or_default().push(item.clone());
    }
    map.into_iter().collect()
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_chunk() {
        assert_eq!(chunk(&[1, 2, 3, 4, 5], 2), vec![vec![1, 2], vec![3, 4], vec![5]]);
    }

    #[test]
    fn test_dedupe() {
        assert_eq!(dedupe(&[1, 1, 2, 3, 3, 3, 4]), vec![1, 2, 3, 4]);
    }

    #[test]
    fn test_filter() {
        let nums = vec![1, 2, 3, 4, 5];
        assert_eq!(filter(&nums, |x| *x > 3), vec![4, 5]);
    }
}
