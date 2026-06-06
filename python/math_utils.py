"""
Math Utility Functions — comprehensive helpers for common math operations.

Provides precise numeric helpers, rounding strategies, sequence math,
statistics, and safe arithmetic for production use.
"""

from __future__ import annotations

import math
import statistics
from decimal import Decimal, ROUND_HALF_UP, ROUND_DOWN, ROUND_UP
from typing import Iterable, Optional


# ──────────────────────────────────────────────
#  Rounding
# ──────────────────────────────────────────────

def round_half_up(value: float, decimals: int = 2) -> float:
    """Round to *decimals* places using banker-unbiased 'half-up' strategy."""
    quant = Decimal("1." + "0" * decimals)
    return float(Decimal(str(value)).quantize(quant, rounding=ROUND_HALF_UP))


def round_down(value: float, decimals: int = 2) -> float:
    """Truncate toward zero to *decimals* places."""
    quant = Decimal("1." + "0" * decimals)
    return float(Decimal(str(value)).quantize(quant, rounding=ROUND_DOWN))


def round_up(value: float, decimals: int = 2) -> float:
    """Round away from zero to *decimals* places."""
    quant = Decimal("1." + "0" * decimals)
    return float(Decimal(str(value)).quantize(quant, rounding=ROUND_UP))


# ──────────────────────────────────────────────
#  Safe arithmetic
# ──────────────────────────────────────────────

def safe_divide(a: float, b: float, default: float = 0.0) -> float:
    """Return *a* / *b* if *b* is non-zero, else *default*."""
    return a / b if b else default


def clamp(value: float, lo: float, hi: float) -> float:
    """Constrain *value* to the inclusive range [*lo*, *hi*]."""
    return max(lo, min(value, hi))


# ──────────────────────────────────────────────
#  Sequence helpers
# ──────────────────────────────────────────────

def percentile(data: Iterable[float], p: float) -> float:
    """Return the *p*-th percentile (0 ≤ *p* ≤ 100) of *data*."""
    sorted_data = sorted(data)
    if not sorted_data:
        raise ValueError("data must not be empty")
    k = (len(sorted_data) - 1) * (p / 100.0)
    f = math.floor(k)
    c = math.ceil(k)
    if f == c:
        return sorted_data[int(k)]
    d0 = sorted_data[f] * (c - k)
    d1 = sorted_data[c] * (k - f)
    return d0 + d1


def safe_mean(data: Iterable[Optional[float]], default: float = 0.0) -> float:
    """Mean of *data* ignoring None/NaN values; returns *default* if empty."""
    cleaned = [x for x in data if x is not None and not math.isnan(x)]
    return statistics.mean(cleaned) if cleaned else default


def lerp(a: float, b: float, t: float) -> float:
    """Linear interpolation between *a* and *b* at parameter *t*."""
    return a + (b - a) * t


# ──────────────────────────────────────────────
#  Number theory
# ──────────────────────────────────────────────

def gcd(*numbers: int) -> int:
    """Greatest common divisor of one or more integers."""
    return math.gcd(*numbers) if numbers else 0  # type: ignore[arg-type]


def lcm(*numbers: int) -> int:
    """Least common multiple of one or more integers."""
    if not numbers:
        return 0

    def _lcm_pair(a: int, b: int) -> int:
        return a * b // math.gcd(a, b)

    result = numbers[0]
    for n in numbers[1:]:
        result = _lcm_pair(result, n)
    return result


def is_within(value: float, target: float, epsilon: float = 1e-9) -> bool:
    """Return True if *value* is within *epsilon* of *target*."""
    return abs(value - target) <= epsilon
