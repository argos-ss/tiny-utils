#!/usr/bin/env bats
#
# Tests for string.sh
# Run: bats bash/test_string.sh
#

setup() {
  source "../string.sh"
}

@test "slugify lowercase basic" {
  run slugify "Hello World!"
  [ "$output" = "hello-world" ]
}

@test "slugify handles special chars" {
  run slugify "Hello @#$ World!!!"
  [ "$output" = "hello-world" ]
}

@test "slugify handles multiple spaces" {
  run slugify "hello   world"
  [ "$output" = "hello-world" ]
}

@test "slugify trims trailing hyphens" {
  run slugify "-hello world-"
  [ "$output" = "hello-world" ]
}

@test "slugify empty input" {
  run slugify ""
  [ "$output" = "" ]
}

@test "trim whitespace" {
  run trim "  hello  "
  [ "$output" = "hello" ]
}

@test "trim only spaces" {
  run trim "   "
  [ "$output" = "" ]
}

@test "lower converts to lowercase" {
  run lower "HELLO"
  [ "$output" = "hello" ]
}

@test "upper converts to uppercase" {
  run upper "hello"
  [ "$output" = "HELLO" ]
}

@test "reverse_words reverses order" {
  run reverse_words "hello world foo"
  [ "$output" = "foo world hello" ]
}

@test "reverse_words single word" {
  run reverse_words "hello"
  [ "$output" = "hello" ]
}

@test "repeat creates repeated char string" {
  run repeat "-" 5
  [ "$output" = "-----" ]
}

@test "repeat with zero count" {
  run repeat "-" 0
  [ "$output" = "" ]
}
