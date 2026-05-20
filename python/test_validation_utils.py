"""Tests for validation_utils."""

import pytest
from python.validation_utils import (
    is_email,
    is_url,
    is_phone,
    is_not_blank,
    is_in_range,
    is_length_between,
)


class TestIsEmail:
    def test_valid_emails(self):
        assert is_email("user@example.com")
        assert is_email("a.b@example.co.uk")
        assert is_email("user+tag@example.org")
        assert is_email("123@abc.com")

    def test_invalid_emails(self):
        assert not is_email("")
        assert not is_email("not-email")
        assert not is_email("@example.com")
        assert not is_email("user@")
        assert not is_email("user@.com")
        assert not is_email("a" * 300 + "@example.com")  # too long


class TestIsUrl:
    def test_valid_urls(self):
        assert is_url("http://example.com")
        assert is_url("https://example.com/path?q=1")
        assert is_url("https://example.com#fragment")
        assert is_url("http://localhost:3000")
        assert is_url("http://192.168.1.1")

    def test_require_https(self):
        assert not is_url("http://example.com", require_https=True)
        assert is_url("https://example.com", require_https=True)

    def test_invalid_urls(self):
        assert not is_url("")
        assert not is_url("not-a-url")
        assert not is_url("ftp://example.com")


class TestIsPhone:
    def test_valid_phone_numbers(self):
        assert is_phone("+905551234567")
        assert is_phone("+14155552671")
        assert is_phone("+3312345678")

    def test_invalid_phone_numbers(self):
        assert not is_phone("")
        assert not is_phone("05551234567")  # missing +
        assert not is_phone("+1")  # too short
        assert not is_phone("not-a-phone")


class TestIsNotBlank:
    def test_valid(self):
        assert is_not_blank("hello")
        assert is_not_blank(" a ")  # has content after strip

    def test_invalid(self):
        assert not is_not_blank("")
        assert not is_not_blank("   ")
        assert not is_not_blank(None)
        assert not is_not_blank(123)


class TestIsInRange:
    def test_in_range(self):
        assert is_in_range(5, 0, 10)
        assert is_in_range(0, 0, 10)  # lower bound
        assert is_in_range(10, 0, 10)  # upper bound

    def test_out_of_range(self):
        assert not is_in_range(-1, 0, 10)
        assert not is_in_range(11, 0, 10)
        assert not is_in_range(20, 0, 10)


class TestIsLengthBetween:
    def test_valid(self):
        assert is_length_between("abc", 1, 5)
        assert is_length_between("a", 1, 5)  # min
        assert is_length_between("abcde", 1, 5)  # max

    def test_invalid(self):
        assert not is_length_between("", 1, 5)
        assert not is_length_between("abcdef", 1, 5)
        assert not is_length_between(None, 1, 5)
