"""Tests for collection_utils."""

import pytest
from python.collection_utils import chunk, flatten, dedupe, partition, batched


class TestChunk:
    def test_basic(self):
        assert list(chunk([1, 2, 3, 4, 5], 2)) == [[1, 2], [3, 4], [5]]

    def test_exact_division(self):
        assert list(chunk([1, 2, 3, 4], 2)) == [[1, 2], [3, 4]]

    def test_size_one(self):
        assert list(chunk([1, 2, 3], 1)) == [[1], [2], [3]]

    def test_size_larger_than_list(self):
        assert list(chunk([1, 2], 10)) == [[1, 2]]

    def test_empty_list(self):
        assert list(chunk([], 3)) == []

    def test_invalid_size(self):
        with pytest.raises(ValueError):
            list(chunk([1, 2], 0))


class TestFlatten:
    def test_flat_list(self):
        assert flatten([1, 2, 3]) == [1, 2, 3]

    def test_nested(self):
        assert flatten([[1, 2], [3, [4, 5]]]) == [1, 2, 3, 4, 5]

    def test_deeply_nested(self):
        assert flatten([1, [2, [3, [4]]]]) == [1, 2, 3, 4]

    def test_empty(self):
        assert flatten([]) == []

    def test_strings_not_flattened(self):
        assert flatten(["hello", ["world"]]) == ["hello", "world"]

    def test_mixed_types(self):
        assert flatten([[1, "a"], [True, None]]) == [1, "a", True, None]


class TestDedupe:
    def test_basic(self):
        assert dedupe([1, 2, 2, 3, 3, 3, 4]) == [1, 2, 3, 4]

    def test_no_duplicates(self):
        assert dedupe([1, 2, 3]) == [1, 2, 3]

    def test_empty(self):
        assert dedupe([]) == []

    def test_with_key(self):
        items = [{"id": 1}, {"id": 2}, {"id": 1}]
        assert dedupe(items, key=lambda x: x["id"]) == [{"id": 1}, {"id": 2}]

    def test_strings(self):
        assert dedupe(["a", "b", "a", "c"]) == ["a", "b", "c"]

    def test_preserves_order(self):
        assert dedupe([3, 1, 2, 1, 3]) == [3, 1, 2]


class TestPartition:
    def test_basic(self):
        passing, failing = partition([1, 2, 3, 4, 5], lambda x: x > 3)
        assert passing == [4, 5]
        assert failing == [1, 2, 3]

    def test_all_pass(self):
        passing, failing = partition([1, 2, 3], lambda x: x > 0)
        assert passing == [1, 2, 3]
        assert failing == []

    def test_all_fail(self):
        passing, failing = partition([1, 2, 3], lambda x: x > 10)
        assert passing == []
        assert failing == [1, 2, 3]

    def test_empty(self):
        passing, failing = partition([], lambda x: True)
        assert passing == []
        assert failing == []

    def test_preserves_order(self):
        passing, failing = partition([5, 1, 4, 2, 3], lambda x: x % 2 == 0)
        assert passing == [4, 2]
        assert failing == [5, 1, 3]


class TestBatched:
    def test_alias_to_chunk(self):
        assert list(batched([1, 2, 3, 4], 2)) == [[1, 2], [3, 4]]
