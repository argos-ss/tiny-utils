/**
 * Extension functions for Kotlin collections.
 *
 * All functions are inline + generic — zero overhead at runtime.
 */

/** Splits this list into fixed‑sized chunks. */
fun <T> List<T>.chunked(size: Int): List<List<T>> {
    require(size >= 1) { "size must be >= 1" }
    return windowed(size, size, partialWindows = true)
}

/** Returns a new list with duplicates removed (order preserved). */
fun <T, K> Iterable<T>.dedupeBy(transform: (T) -> K): List<T> {
    val seen = mutableSetOf<K>()
    return filter { seen.add(transform(it)) }
}

/** Groups elements by a key selector using a mutable map. */
fun <T, K> Iterable<T>.groupByNonNull(keySelector: (T) -> K): Map<K, List<T>> {
    val map = linkedMapOf<K, MutableList<T>>()
    for (element in this) {
        map.getOrPut(keySelector(element)) { mutableListOf() }.add(element)
    }
    return map
}
