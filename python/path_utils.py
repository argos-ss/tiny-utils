"""
path_utils.py — File path manipulation utilities.

Provides helpers for common path operations not always ergonomic
with the stdlib: normalise, expand, relativise, common ancestor,
and safe filename generation.
"""

from __future__ import annotations

import os
import re
from pathlib import Path
from typing import Optional


def common_ancestor(paths: list[str | Path]) -> Path:
    """Return the deepest common parent directory among a list of paths.

    Raises ValueError if the list is empty.
    """
    if not paths:
        raise ValueError("paths must be non-empty")

    resolved = [Path(p).resolve() for p in paths]
    # Split each into its component parts
    parts_list = [list(p.parts) for p in resolved]

    ancestor = parts_list[0]
    for parts in parts_list[1:]:
        limit = min(len(ancestor), len(parts))
        ancestor = ancestor[:limit]
        for i in range(limit):
            if ancestor[i] != parts[i]:
                ancestor = ancestor[:i]
                break
    return Path(*ancestor)


def safe_filename(text: str, replacement: str = "_", max_len: int = 200) -> str:
    """Transform *text* into a cross-platform safe filename.

    Characters that are illegal on Windows or problematic on Unix are
    replaced with *replacement*.  Runs of replacement chars are
    collapsed into a single one.
    """
    cleaned = re.sub(r'[<>:"/\\|?*\x00-\x1f]', replacement, text)
    cleaned = re.sub(rf"\{replacement}+", replacement, cleaned)
    cleaned = cleaned.strip(replacement)
    if not cleaned:
        cleaned = "untitled"
    return cleaned[:max_len]


def ensure_ext(path: str | Path, ext: str) -> Path:
    """Append *ext* to *path* if it does not already end with it.

    The extension should include the leading dot (e.g. ``".json"``).
    """
    p = Path(path)
    if not p.suffix.lower() == ext.lower():
        p = p.with_suffix(p.suffix + ext if p.suffix else ext)
    return p


def shrink_home(path: str | Path) -> str:
    """Replace the current user's home directory with ``~``."""
    p = Path(path).resolve()
    home = Path.home()
    try:
        relative = p.relative_to(home)
    except ValueError:
        return str(p)
    return f"~/{relative}"


def count_files(root: str | Path, pattern: str = "*") -> int:
    """Count files matching *pattern* under *root* (non-recursive)."""
    return sum(1 for _ in Path(root).parent.glob(pattern) if _.is_file())


def splitall(path: str | Path) -> list[str]:
    """Split a path into every single component.

    ``splitall("a/b/c")  →  ["a", "b", "c"]``
    """
    parts = []
    p = Path(path)
    while True:
        parent, tail = os.path.split(str(p))
        if tail:
            parts.append(tail)
        if parent == str(p):
            if parent:
                parts.append(parent)
            break
        p = Path(parent)
    parts.reverse()
    return parts


def is_subpath(child: str | Path, parent: str | Path) -> bool:
    """Return True if *child* is inside *parent* (or the same)."""
    try:
        Path(child).resolve().relative_to(Path(parent).resolve())
        return True
    except ValueError:
        return False
