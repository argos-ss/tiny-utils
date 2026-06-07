"""Network utility functions — URL parsing, port validation."""
from urllib.parse import urlparse

def is_valid_url(url: str) -> bool:
    """Check if a string is a well-formed HTTP(S) URL."""
    try:
        result = urlparse(url)
        return result.scheme in ("http", "https") and bool(result.netloc)
    except ValueError:
        return False

def is_valid_port(port: int) -> bool:
    """Check if an integer is a valid TCP port number."""
    return 0 < port <= 65535
