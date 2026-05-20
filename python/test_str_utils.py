"""Tests for str_utils — pure string transformation utilities."""

import pytest
from python.str_utils import slugify, truncate, camel_to_snake, reverse_words, to_pascal


class TestSlugify:
    def test_basic(self):
        assert slugify("Hello World!") == "hello-world"

    def test_special_chars_removed(self):
        assert slugify("Hello @#$ World!!!") == "hello-world"

    def test_multiple_spaces(self):
        assert slugify("hello   world") == "hello-world"

    def test_trailing_hyphens(self):
        assert slugify("-hello world-") == "hello-world"

    def test_unicode(self):
        assert slugify("çalışma modülü") == "çalışma-modülü"

    def test_empty_string(self):
        assert slugify("") == ""

    def test_numbers(self):
        assert slugify("Version 2.0 is out!") == "version-20-is-out"


class TestTruncate:
    def test_no_truncation_needed(self):
        assert truncate("hello", 10) == "hello"

    def test_truncate_at_word_boundary(self):
        assert truncate("hello world foo", 8) == "hello..."

    def test_exact_length(self):
        assert truncate("hello", 5) == "hello"

    def test_custom_suffix(self):
        assert truncate("hello world foo bar", 10, " [truncated]") == "hello [truncated]"

    def test_no_word_boundary(self):
        assert truncate("abcdefghij", 5) == "abcde..."

    def test_empty_string(self):
        assert truncate("", 5) == ""

    def test_max_length_zero(self):
        assert truncate("hello", 0) == "..."


class TestCamelToSnake:
    def test_camel_case(self):
        assert camel_to_snake("camelCase") == "camel_case"

    def test_pascal_case(self):
        assert camel_to_snake("PascalCase") == "pascal_case"

    def test_single_word(self):
        assert camel_to_snake("hello") == "hello"

    def test_acronyms(self):
        assert camel_to_snake("XMLParser") == "xml_parser"

    def test_all_caps(self):
        assert camel_to_snake("SOME_VALUE") == "some_value"

    def test_empty_string(self):
        assert camel_to_snake("") == ""


class TestReverseWords:
    def test_basic(self):
        assert reverse_words("hello world") == "world hello"

    def test_multiple_words(self):
        assert reverse_words("a b c d") == "d c b a"

    def test_single_word(self):
        assert reverse_words("hello") == "hello"

    def test_empty_string(self):
        assert reverse_words("") == ""

    def test_extra_spaces(self):
        assert reverse_words("hello   world") == "world hello"


class TestToPascal:
    def test_kebab_case(self):
        assert to_pascal("hello-world") == "HelloWorld"

    def test_snake_case(self):
        assert to_pascal("hello_world") == "HelloWorld"

    def test_single_word(self):
        assert to_pascal("hello") == "Hello"

    def test_empty_string(self):
        assert to_pascal("") == ""

    def test_mixed(self):
        assert to_pascal("hello-world_foo") == "HelloWorldFoo"

    def test_numbers(self):
        assert to_pascal("item2-price") == "Item2Price"
