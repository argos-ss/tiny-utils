"""
Input validation utilities.

All functions are pure — no side effects, no state.
Returns bool for pass/fail; messages are caller responsibility.
"""

import re
from typing import Any

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

_EMAIL_PATTERN = re.compile(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
)

_URL_PATTERN = re.compile(
    r"^https?://"
    r"(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+[A-Z]{2,6}\.?|"
    r"localhost|"
    r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"
    r"(?::\d+)?"
    r"(?:/?|[/?]\S+)$",
    re.IGNORECASE,
)

_PHONE_INTERNATIONAL = re.compile(r"^\+[1-9]\d{6,14}$")

# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------


def is_email(value: str) -> bool:
    """Return True when *value* is a syntactically valid email address.

    Covers the vast majority of real-world addresses per RFC 5322
    without the full spec complexity.
    """
    if not isinstance(value, str) or len(value) > 254:
        return False
    return bool(_EMAIL_PATTERN.match(value))


def is_url(value: str, require_https: bool = False) -> bool:
    """Return True when *value* is a well-formed HTTP(S) URL.

    Args:
        value:       Candidate URL.
        require_https: When True, reject http:// schemes.
    """
    if not isinstance(value, str) or len(value) > 2048:
        return False
    match = _URL_PATTERN.match(value)
    if not match:
        return False
    if require_https and not value.lower().startswith("https://"):
        return False
    return True


def is_phone(value: str) -> bool:
    """Return True when *value* is an E.164 international phone number.

    Must start with ``+`` followed by country code (1-3 digits) and
    subscriber number (6-14 digits).
    """
    return isinstance(value, str) and bool(_PHONE_INTERNATIONAL.match(value))


def is_not_blank(value: Any) -> bool:
    """Return True when *value* is a non-empty, non-whitespace string."""
    return isinstance(value, str) and len(value.strip()) > 0


def is_in_range(value: float, low: float, high: float) -> bool:
    """Return True when *value* falls within [low, high] inclusive."""
    return low <= value <= high


def is_length_between(value: str, min_len: int, max_len: int) -> bool:
    """Return True when ``min_len <= len(value) <= max_len``."""
    return isinstance(value, str) and min_len <= len(value) <= max_len
