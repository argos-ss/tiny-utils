package com.tinyutils;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

class StringUtilsTest {

    // --- slugify ---

    @Test void slugifyBasic() {
        assertEquals("hello-world", StringUtils.slugify("Hello World!"));
    }

    @Test void slugifySpecialChars() {
        assertEquals("hello-world", StringUtils.slugify("Hello @#$ World!!!"));
    }

    @Test void slugifyMultipleSpaces() {
        assertEquals("hello-world", StringUtils.slugify("hello   world"));
    }

    @Test void slugifyTrimHyphens() {
        assertEquals("hello-world", StringUtils.slugify("-hello world-"));
    }

    @Test void slugifyNull() {
        assertEquals("", StringUtils.slugify(null));
    }

    @Test void slugifyEmpty() {
        assertEquals("", StringUtils.slugify(""));
    }

    @ParameterizedTest
    @CsvSource({
        "abc, abc",
        "Hello World!, hello-world",
        "'', ''"
    })
    void slugifyParameterized(String input, String expected) {
        assertEquals(expected, StringUtils.slugify(input));
    }

    // --- truncate ---

    @Test void truncateNoTruncation() {
        assertEquals("hello", StringUtils.truncate("hello", 10));
    }

    @Test void truncateAtWordBoundary() {
        assertEquals("hello...", StringUtils.truncate("hello world foo", 8));
    }

    @Test void truncateCustomSuffix() {
        assertEquals("hello...[more]", StringUtils.truncate("hello world foo bar", 10, "...[more]"));
    }

    @Test void truncateNoBoundary() {
        assertEquals("abcde...", StringUtils.truncate("abcdefghij", 5));
    }

    @Test void truncateNull() {
        assertNull(StringUtils.truncate(null, 10));
    }

    @Test void truncateExactLength() {
        assertEquals("hello", StringUtils.truncate("hello", 5));
    }
}
