package com.tinyutils

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class StringsTest {

    // --- slugify ---

    @Test
    fun `slugify basic`() {
        assertEquals("hello-world", "Hello World!".slugify())
    }

    @Test
    fun `slugify special chars`() {
        assertEquals("hello-world", "Hello @#$ World!!!".slugify())
    }

    @Test
    fun `slugify multiple spaces`() {
        assertEquals("hello-world", "hello   world".slugify())
    }

    @Test
    fun `slugify trim hyphens`() {
        assertEquals("hello-world", "-hello world-".slugify())
    }

    @Test
    fun `slugify empty string`() {
        assertEquals("", "".slugify())
    }

    // --- truncate ---

    @Test
    fun `truncate no truncation`() {
        assertEquals("hello", "hello".truncate(maxLength = 10))
    }

    @Test
    fun `truncate at word boundary`() {
        assertEquals("hello...", "hello world foo".truncate(maxLength = 8))
    }

    @Test
    fun `truncate custom suffix`() {
        assertEquals("hello..", "hello world foo".truncate(maxLength = 8, suffix = ".."))
    }

    @Test
    fun `truncate no boundary`() {
        assertEquals("abcde...", "abcdefghij".truncate(maxLength = 5))
    }

    // --- camelToSnake ---

    @Test
    fun `camel to snake`() {
        assertEquals("camel_case", "camelCase".camelToSnake())
    }

    @Test
    fun `pascal to snake`() {
        assertEquals("pascal_case", "PascalCase".camelToSnake())
    }

    @Test
    fun `camel to snake acronyms`() {
        assertEquals("xml_parser", "XMLParser".camelToSnake())
    }

    @Test
    fun `camel to snake single`() {
        assertEquals("hello", "hello".camelToSnake())
    }

    // --- reverseWords ---

    @Test
    fun `reverse words basic`() {
        assertEquals("world hello", "hello world".reverseWords())
    }

    @Test
    fun `reverse words multiple`() {
        assertEquals("d c b a", "a b c d".reverseWords())
    }

    @Test
    fun `reverse words single`() {
        assertEquals("hello", "hello".reverseWords())
    }

    // --- toPascal ---

    @Test
    fun `to pascal kebab`() {
        assertEquals("HelloWorld", "hello-world".toPascal())
    }

    @Test
    fun `to pascal snake`() {
        assertEquals("HelloWorld", "hello_world".toPascal())
    }

    @Test
    fun `to pascal single`() {
        assertEquals("Hello", "hello".toPascal())
    }
}
