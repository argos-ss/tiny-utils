import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlin.test.assertFailsWith

class CollectionsTest {

    // --- chunked ---

    @Test
    fun `chunked basic`() {
        assertEquals(
            listOf(listOf(1, 2), listOf(3, 4), listOf(5)),
            listOf(1, 2, 3, 4, 5).chunked(2)
        )
    }

    @Test
    fun `chunked exact division`() {
        assertEquals(
            listOf(listOf(1, 2), listOf(3, 4)),
            listOf(1, 2, 3, 4).chunked(2)
        )
    }

    @Test
    fun `chunked size larger than list`() {
        assertEquals(
            listOf(listOf(1, 2)),
            listOf(1, 2).chunked(10)
        )
    }

    @Test
    fun `chunked invalid size`() {
        assertFailsWith<IllegalArgumentException> {
            listOf(1).chunked(0)
        }
    }

    // --- dedupeBy ---

    @Test
    fun `dedupe by property`() {
        data class Item(val id: Int, val name: String)
        val items = listOf(Item(1, "a"), Item(2, "b"), Item(1, "c"))
        val result = items.dedupeBy { it.id }
        assertEquals(2, result.size)
        assertEquals("a", result[0].name)
    }

    // --- groupByNonNull ---

    @Test
    fun `group by non null`() {
        val items = listOf("apple", "banana", "apricot")
        val grouped = items.groupByNonNull { it.first() }
        assertEquals(2, grouped.size)
        assertEquals(listOf("apple", "apricot"), grouped['a'])
        assertEquals(listOf("banana"), grouped['b'])
    }

    // --- randomSample ---

    @Test
    fun `random sample returns correct count`() {
        val items = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
        val sample = items.randomSample(3)
        assertEquals(3, sample.size)
        // All elements in sample should be from original
        assertTrue(sample.all { it in items })
    }

    @Test
    fun `random sample does not exceed list size`() {
        val items = listOf(1, 2)
        val sample = items.randomSample(10)
        assertEquals(2, sample.size)
    }
}
