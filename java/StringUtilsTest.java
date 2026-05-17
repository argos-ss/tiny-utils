package com.tinyutils;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class StringUtilsTest {
    @Test void testSlugify() {
        assertEquals("hello-world", StringUtils.slugify("Hello World!"));
    }

    @Test void testSlugifyNull() {
        assertEquals("", StringUtils.slugify(null));
    }

    @Test void testTruncate() {
        assertEquals("hello...", StringUtils.truncate("hello world foo", 8));
    }
}
