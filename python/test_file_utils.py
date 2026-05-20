"""Tests for file_utils — file-system helpers."""

import os
import tempfile
import pytest
from python.file_utils import read, write, size_label, list_tree


class TestRead:
    def test_read_existing_file(self):
        with tempfile.NamedTemporaryFile(mode="w", suffix=".txt", delete=False, encoding="utf-8") as f:
            f.write("hello world")
            tmp = f.name
        try:
            content, error = read(tmp)
            assert content == "hello world"
            assert error is None
        finally:
            os.unlink(tmp)

    def test_read_nonexistent_file(self):
        content, error = read("/nonexistent/path/file.txt")
        assert content == ""
        assert error is not None
        assert "not found" in error.lower()

    def test_read_with_default(self):
        content, error = read("/nonexistent/path/file.txt", default="fallback")
        assert content == "fallback"
        assert error is not None

    def test_read_directory(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            content, error = read(tmpdir)
            assert content == ""
            assert error is not None
            assert "directory" in error.lower()


class TestWrite:
    def test_write_new_file(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            path = os.path.join(tmpdir, "nested", "test.txt")
            error = write(path, "hello world")
            assert error is None
            assert os.path.isfile(path)
            with open(path, "r", encoding="utf-8") as f:
                assert f.read() == "hello world"

    def test_write_overwrite(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            path = os.path.join(tmpdir, "test.txt")
            write(path, "first")
            error = write(path, "second")
            assert error is None
            with open(path, "r", encoding="utf-8") as f:
                assert f.read() == "second"

    def test_write_to_readonly_dir(self):
        # Only runs on platforms where this is feasible
        with tempfile.TemporaryDirectory() as tmpdir:
            os.chmod(tmpdir, 0o444)
            path = os.path.join(tmpdir, "test.txt")
            error = write(path, "hello")
            assert error is not None


class TestSizeLabel:
    def test_bytes(self):
        assert size_label(0) == "0.0 B"
        assert size_label(512) == "512.0 B"

    def test_kilobytes(self):
        assert size_label(1024) == "1.0 KB"
        assert size_label(2048) == "2.0 KB"

    def test_megabytes(self):
        assert size_label(1048576) == "1.0 MB"

    def test_gigabytes(self):
        assert size_label(1073741824) == "1.0 GB"

    def test_terabytes(self):
        assert size_label(1099511627776) == "1.0 TB"

    def test_negative(self):
        with pytest.raises(ValueError):
            size_label(-1)


class TestListTree:
    def test_empty_directory(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            files = list_tree(tmpdir)
            assert files == []

    def test_files_in_directory(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            open(os.path.join(tmpdir, "a.txt"), "w").close()
            open(os.path.join(tmpdir, "b.txt"), "w").close()
            os.makedirs(os.path.join(tmpdir, "sub"), exist_ok=True)
            open(os.path.join(tmpdir, "sub", "c.txt"), "w").close()
            files = list_tree(tmpdir)
            assert "a.txt" in files
            assert "b.txt" in files
            assert "sub/c.txt" in files
            assert len(files) == 3

    def test_with_pattern(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            open(os.path.join(tmpdir, "a.py"), "w").close()
            open(os.path.join(tmpdir, "b.txt"), "w").close()
            files = list_tree(tmpdir, pattern="*.py")
            assert files == ["a.py"]
