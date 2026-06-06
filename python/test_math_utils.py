"""Tests for math_utils.py."""

import math
import pytest
from math_utils import (
    round_half_up,
    round_down,
    round_up,
    safe_divide,
    clamp,
    percentile,
    safe_mean,
    lerp,
    gcd,
    lcm,
    is_within,
)


class TestRounding:
    def test_round_half_up(self):
        assert round_half_up(2.345, 2) == 2.35
        assert round_half_up(2.344, 2) == 2.34
        assert round_half_up(2.5, 0) == 3.0

    def test_round_down(self):
        assert round_down(2.999, 2) == 2.99
        assert round_down(-2.999, 2) == -2.99

    def test_round_up(self):
        assert round_up(2.001, 2) == 2.01
        assert round_up(-2.001, 2) == -2.01


class TestSafeArithmetic:
    def test_safe_divide_normal(self):
        assert safe_divide(10, 2) == 5.0

    def test_safe_divide_by_zero(self):
        assert safe_divide(10, 0) == 0.0

    def test_safe_divide_custom_default(self):
        assert safe_divide(10, 0, -1.0) == -1.0

    def test_clamp_in_range(self):
        assert clamp(5, 0, 10) == 5

    def test_clamp_below(self):
        assert clamp(-5, 0, 10) == 0

    def test_clamp_above(self):
        assert clamp(15, 0, 10) == 10


class TestSequences:
    def test_percentile_median(self):
        assert percentile([1, 2, 3, 4, 5], 50) == 3.0

    def test_percentile_quartiles(self):
        assert percentile([1, 2, 3, 4], 25) == 1.75
        assert percentile([1, 2, 3, 4], 75) == 3.25

    def test_percentile_empty(self):
        with pytest.raises(ValueError):
            percentile([], 50)

    def test_safe_mean(self):
        assert safe_mean([1.0, 2.0, 3.0]) == 2.0

    def test_safe_mean_with_none(self):
        assert safe_mean([1.0, None, 3.0]) == 2.0

    def test_safe_mean_empty(self):
        assert safe_mean([]) == 0.0

    def test_lerp(self):
        assert lerp(0, 10, 0.5) == 5.0
        assert lerp(0, 10, 0) == 0.0
        assert lerp(0, 10, 1) == 10.0


class TestNumberTheory:
    def test_gcd(self):
        assert gcd(12, 8) == 4
        assert gcd(7, 13) == 1

    def test_lcm(self):
        assert lcm(4, 6) == 12
        assert lcm(7, 13) == 91

    def test_is_within(self):
        assert is_within(3.0, 3.0) is True
        assert is_within(3.000000001, 3.0) is True
        assert is_within(3.1, 3.0, 0.05) is False
