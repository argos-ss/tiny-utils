#!/usr/bin/env bats
#
# Tests for file-ops.sh
# Run: bats bash/test_file-ops.sh
#

setup() {
  source "../file-ops.sh"
  TEST_DIR=$(mktemp -d)
}

teardown() {
  rm -rf "$TEST_DIR"
}

@test "backup creates copy of a file" {
  echo "hello" > "$TEST_DIR/test.txt"
  run backup "$TEST_DIR/test.txt" "$TEST_DIR/test.txt.bak"
  [ -f "$TEST_DIR/test.txt.bak" ]
  diff "$TEST_DIR/test.txt" "$TEST_DIR/test.txt.bak"
}

@test "backup creates copy of a directory" {
  mkdir -p "$TEST_DIR/mydir"
  echo "data" > "$TEST_DIR/mydir/file.txt"
  run backup "$TEST_DIR/mydir" "$TEST_DIR/mydir.bak"
  [ -d "$TEST_DIR/mydir.bak" ]
  [ -f "$TEST_DIR/mydir.bak/file.txt" ]
}

@test "backup returns error for missing path" {
  run backup "/nonexistent/path"
  [ "$status" -ne 0 ]
}

@test "dirsize shows human-readable size" {
  dd if=/dev/zero of="$TEST_DIR/test.bin" bs=1024 count=10 2>/dev/null
  run dirsize "$TEST_DIR"
  [ "$status" -eq 0 ]
  [[ "$output" =~ [0-9]+[KMG] ]]
}

@test "filecount counts files recursively" {
  mkdir -p "$TEST_DIR/sub"
  touch "$TEST_DIR/a.txt" "$TEST_DIR/b.txt" "$TEST_DIR/sub/c.txt"
  run filecount "$TEST_DIR"
  [ "$output" -eq 3 ]
}

@test "rename_ext renames file extensions" {
  touch "$TEST_DIR/file.txt" "$TEST_DIR/other.txt"
  cd "$TEST_DIR" && run rename_ext "txt" "md"
  [ -f "$TEST_DIR/file.md" ]
  [ -f "$TEST_DIR/other.md" ]
  [ ! -f "$TEST_DIR/file.txt" ]
}
