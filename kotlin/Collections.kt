inline fun <T> List<T>.chunked(size: Int): List<List<T>> {
    require(size >= 1) { "size must be >= 1" }
    return windowed(size, size, partialWindows = true)
}

inline fun <T, K> Iterable<T>.dedupeBy(transform: (T) -> K): List<T> {
    val seen = mutableSetOf<K>()
    return filter { seen.add(transform(it)) }
}

inline fun <T, K> Iterable<T>.groupByNonNull(keySelector: (T) -> K): Map<K, List<T>> {
    val map = linkedMapOf<K, MutableList<T>>()
    for (element in this) map.getOrPut(keySelector(element)) { mutableListOf() }.add(element)
    return map
}
fun <T> List<T>.randomSample(count: Int): List<T> = shuffled().take(count)
fun <T> List<T>.randomSample(count: Int): List<T> = shuffled().take(count)
fun <T> List<T>.randomSample(count: Int): List<T> = shuffled().take(count)
fun <T> List<T>.randomSample(count: Int): List<T> = shuffled().take(count)
