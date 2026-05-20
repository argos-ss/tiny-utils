#!/usr/bin/env bats
#
# Tests for colors.sh
# Run: bats bash/test_colors.sh
#

setup() {
  source "../colors.sh"
}

@test "info prints [INFO] prefix" {
  run info "test message"
  [[ "$output" =~ \[INFO\] ]]
  [[ "$output" =~ "test message" ]]
}

@test "success prints [ OK ] prefix" {
  run success "done"
  [[ "$output" =~ \[\ OK\ \] ]]
}

@test "warn prints [WARN] prefix" {
  run warn "caution"
  [[ "$output" =~ \[WARN\] ]]
}

@test "error prints [ERR] prefix and goes to stderr" {
  run error "fail"
  [[ "$output" =~ \[ERR\] ]]
  [[ "$status" -eq 0 ]]
}

@test "header prints formatted header" {
  run header "testing"
  [[ "$output" =~ testing ]]
  [[ "$output" =~ === ]]
}
