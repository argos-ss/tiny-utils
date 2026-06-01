"""
Core string transformation utilities.

All functions are pure — no side effects, no state.
Each function has a single, well-defined responsibility.
"""

import re
from typing import Optional


# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

_NON_WORD_PATTERN = re.compile(r"[^\w\s-]")
_SPACE_PATTERN = re.compile(r"[-\s]+")
_CAMEL_FIRST = re.compile(r"([A-Z]+)([A-Z][a-z])")
_CAMEL_SECOND = re.compile(r"([a-z0-9])([A-Z])")

# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def slugify(text: str) -> str:
    """Convert free-form text into a URL-safe slug.

    Args:
        text: Input string (e.g. "Hello World!").

    Returns:
        Lowercase, hyphen-delimited slug (e.g. "hello-world").
    """
    cleaned = _NON_WORD_PATTERN.sub("", text.lower().strip())
    slug = _SPACE_PATTERN.sub("-", cleaned)
    return slug.strip("-")


def truncate(text: str, max_length: int = 80, suffix: str = "...") -> str:
    """Truncate text at the nearest word boundary without exceeding *max_length*.

    Args:
        text:      Input string.
        max_length: Hard character limit.
        suffix:    Appended when truncation occurs.

    Returns:
        Original or truncated string followed by *suffix*.
    """
    if len(text) <= max_length:
        return text

    candidate = text[:max_length]
    boundary = candidate.rfind(" ")

    if boundary > 0:
        return candidate[:boundary] + suffix
    return candidate + suffix


def camel_to_snake(name: str) -> str:
    """Convert a *camelCase* or *PascalCase* identifier to *snake_case*.

    Args:
        name: Camel-cased identifier.

    Returns:
        Snake-cased equivalent.
    """
    step1 = _CAMEL_FIRST.sub(r"\1_\2", name)
    step2 = _CAMEL_SECOND.sub(r"\1_\2", step1)
    return step2.lower()


def reverse_words(text: str) -> str:
    """Reverse the order of whitespace-delimited words.

    Args:
        text: Input sentence.

    Returns:
        Sentence with words in reversed order.
    """
    return " ".join(reversed(text.split()))


def to_pascal(text: str) -> str:
    """Convert dash-/underscore-delimited text to PascalCase.

    Args:
        text: kebab-case or snake_case input.

    Returns:
        PascalCase output (e.g. "hello-world" → "HelloWorld").
    """
    return "".join(word.capitalize() for word in re.split(r"[-_]", text))
def is_palindrome(text: str) -> bool:
    """Check if text reads the same forward and backward (ignoring case and non-alphanumeric)."""
    cleaned = re.sub(r'[^a-zA-Z0-9]', '', text).lower()
    return cleaned == cleaned[::-1]
