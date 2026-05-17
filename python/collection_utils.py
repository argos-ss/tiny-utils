"""
Collection manipulation utilities.

Every function is immutable (returns a new collection) and
typed for maximum safety.
"""

from typing import (
    Callable,
    Generic,
    Iterable,
    Iterator,
    List,
    Optional,
    Tuple,
    TypeVar,
)

T = TypeVar("T")
K = TypeVar("K")  # group key type
V = TypeVar("V")


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def chunk(items: List[T], size: int) -> Iterator[List[T]]:
    """Split a list into fixed‑sized, non‑overlapping chunks.

    Args:
        items: Source list.
        size:  Maximum chunk length (must be > 0).

    Yields:
        Successive list slices.
    """
    if size < 1:
        raise ValueError(f"chunk size must be ≥ 1, got {size}")

    for i in range(0, len(items), size):
        yield items[i : i + size]


def flatten(nested: Iterable) -> List:
    """Recursively flatten nested iterables (except strings & bytes).

    Args:
        nested: Arbitrarily nested iterable.

    Returns:
        Flat list of leaf elements.
    """
    result: List = []
    _flatten(nested, result)
    return result


def _flatten(items: Iterable, accumulator: List) -> None:
    """Internal recursive flatten helper."""
    for item in items:
        if isinstance(item, (str, bytes)):
            accumulator.append(item)
        elif isinstance(item, Iterable):
            _flatten(item, accumulator)
        else:
            accumulator.append(item)


def dedupe(items: List[T], key: Optional[Callable[[T], K]] = None) -> List[T]:
    """Remove duplicate items while preserving order.

    Args:
        items: Input list.
        key:   Optional identity function for custom equality.

    Returns:
        List with duplicates removed.
    """
    seen: set = set()
    result: List[T] = []

    for item in items:
        identifier = key(item) if key else item
        if identifier not in seen:
            seen.add(identifier)
            result.append(item)

    return result


def partition(items: List[T], predicate: Callable[[T], bool]) -> Tuple[List[T], List[T]]:
    """Split a list into two buckets based on a predicate.

    Args:
        items:     Input list.
        predicate: Truthy / falsy filter.

    Returns:
        (passing, failing) — both preserve input order.
    """
    yes: List[T] = []
    no: List[T] = []
    for item in items:
        (yes if predicate(item) else no).append(item)
    return yes, no


def batched(items: List[T], size: int) -> Iterator[List[T]]:
    """Alias for :func:`chunk` — returns iterable of batches."""
    yield from chunk(items, size)
