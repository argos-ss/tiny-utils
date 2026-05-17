"""
File-system helpers with explicit error handling.

Every public function returns a result that the caller can inspect —
IOError / PermissionError are never swallowed silently.
"""

import os
from pathlib import Path
from typing import Optional, Tuple


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

FileContent = str
ErrorMsg = str
ReadResult = Tuple[Optional[FileContent], Optional[ErrorMsg]]


def read(path: str, default: str = "") -> ReadResult:
    """Read a file's text content safely.

    Args:
        path:    Absolute or relative file path.
        default: Fallback content when the file does not exist.

    Returns:
        (content, None) on success,
        (default, error_message) on failure.
    """
    try:
        return Path(path).read_text(encoding="utf-8"), None
    except FileNotFoundError:
        return default, f"File not found: {path}"
    except PermissionError:
        return default, f"Permission denied: {path}"
    except IsADirectoryError:
        return default, f"Path is a directory: {path}"


def write(path: str, content: str) -> Optional[ErrorMsg]:
    """Write text content to a file, creating parent directories as needed.

    Args:
        path:    Destination file path.
        content: UTF‑8 text content.

    Returns:
        None on success, error message on failure.
    """
    try:
        Path(path).parent.mkdir(parents=True, exist_ok=True)
        Path(path).write_text(content, encoding="utf-8")
        return None
    except PermissionError:
        return f"Permission denied: {path}"
    except OSError as exc:
        return f"OS error writing {path}: {exc}"


def size_label(bytes_count: int) -> str:
    """Format a byte count as a human-readable string.

    Args:
        bytes_count: Non‑negative integer.

    Returns:
        Formatted label (e.g. "4.2 MB").
    """
    if bytes_count < 0:
        raise ValueError(f"bytes_count must be ≥ 0, got {bytes_count}")

    _UNITS = ("B", "KB", "MB", "GB", "TB")
    value = float(bytes_count)

    for unit in _UNITS:
        if value < 1024.0:
            return f"{value:.1f} {unit}"
        value /= 1024.0

    return f"{value:.1f} PB"


def list_tree(root: str = ".", pattern: str = "*") -> list[str]:
    """Recursively list file paths matching a glob pattern.

    Args:
        root:    Base directory.
        pattern: Glob pattern (default: all files).

    Returns:
        Sorted list of relative file paths.
    """
    return sorted(
        str(p.relative_to(root))
        for p in Path(root).rglob(pattern)
        if p.is_file()
    )
