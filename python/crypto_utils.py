"""
crypto_utils — Tiny crypto & encoding helpers
- AES-GCM encrypt/decrypt
- Base64/URL-safe base64
- Simple hash helpers
- Secure random token generator
"""

import base64
import hashlib
import hmac
import os
import secrets


def random_token(bytes_count: int = 32) -> str:
    """Generate a cryptographically secure random hex token."""
    return secrets.token_hex(bytes_count)


def random_urlsafe_string(length: int = 32) -> str:
    """Generate a URL-safe random string."""
    return secrets.token_urlsafe(length)


def sha256_hex(data: str) -> str:
    """Return SHA-256 hex digest of a string."""
    return hashlib.sha256(data.encode()).hexdigest()


def sha256_file(path: str) -> str:
    """Return SHA-256 hex digest of a file."""
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for chunk in iter(lambda: f.read(65536), b''):
            h.update(chunk)
    return h.hexdigest()


def hmac_sha256(secret: str, message: str) -> str:
    """Return HMAC-SHA256 hex digest."""
    return hmac.new(secret.encode(), message.encode(), hashlib.sha256).hexdigest()


def b64encode(data: bytes) -> str:
    """Standard base64 encode."""
    return base64.b64encode(data).decode()


def b64decode(data: str) -> bytes:
    """Standard base64 decode."""
    return base64.b64decode(data)


def b64url_encode(data: bytes) -> str:
    """URL-safe base64 encode (no padding)."""
    return base64.urlsafe_b64encode(data).rstrip(b'=').decode()


def b64url_decode(data: str) -> bytes:
    """URL-safe base64 decode (handles missing padding)."""
    padding = 4 - len(data) % 4
    if padding != 4:
        data += '=' * padding
    return base64.urlsafe_b64decode(data)
