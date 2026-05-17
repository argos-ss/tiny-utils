"""File system helpers — safe read/write, extension check, size formatting."""
import os
from pathlib import Path


def safe_read(path: str, default: str = '') -> str:
    """Read file safely, return default on error."""
    try:
        return Path(path).read_text(encoding='utf-8')
    except (FileNotFoundError, PermissionError):
        return default


def safe_write(path: str, content: str) -> bool:
    """Write file safely, creating parent dirs."""
    try:
        Path(path).parent.mkdir(parents=True, exist_ok=True)
        Path(path).write_text(content, encoding='utf-8')
        return True
    except (PermissionError, IsADirectoryError):
        return False


def format_size(bytes_: int) -> str:
    """Format byte size to human readable."""
    for unit in ('B', 'KB', 'MB', 'GB'):
        if bytes_ < 1024:
            return f'{bytes_:.1f} {unit}'
        bytes_ /= 1024
    return f'{bytes_:.1f} TB'
