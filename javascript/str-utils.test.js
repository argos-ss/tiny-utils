/**
 * Tests for str-utils.js
 *
 * Run: node --test javascript/str-utils.test.js
 */

import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { slugify, truncate, reverseWords, escapeRegex } from "./str-utils.js";

describe("slugify", () => {
  it("converts basic text to slug", () => {
    assert.equal(slugify("Hello World!"), "hello-world");
  });

  it("removes special characters", () => {
    assert.equal(slugify("Hello @#$ World!!!"), "hello-world");
  });

  it("handles multiple spaces", () => {
    assert.equal(slugify("hello   world"), "hello-world");
  });

  it("trims leading/trailing hyphens", () => {
    assert.equal(slugify("-hello world-"), "hello-world");
  });

  it("handles empty string", () => {
    assert.equal(slugify(""), "");
  });
});

describe("truncate", () => {
  it("returns original when shorter than maxLen", () => {
    assert.equal(truncate("hello", 10), "hello");
  });

  it("truncates at word boundary", () => {
    assert.equal(truncate("hello world foo", 8), "hello...");
  });

  it("uses custom suffix", () => {
    assert.equal(truncate("hello world foo bar", 10, " [more]"), "hello [more]");
  });

  it("handles exact match", () => {
    assert.equal(truncate("hello", 5), "hello");
  });

  it("handles no word boundary", () => {
    assert.equal(truncate("abcdefghij", 5), "abcde...");
  });
});

describe("reverseWords", () => {
  it("reverses word order", () => {
    assert.equal(reverseWords("hello world"), "world hello");
  });

  it("handles multiple words", () => {
    assert.equal(reverseWords("a b c d"), "d c b a");
  });

  it("handles single word", () => {
    assert.equal(reverseWords("hello"), "hello");
  });

  it("handles empty string", () => {
    assert.equal(reverseWords(""), "");
  });
});

describe("escapeRegex", () => {
  it("escapes special regex characters", () => {
    assert.equal(escapeRegex("a.b(c)"), "a\\.b\\(c\\)");
  });

  it("escapes dollar and caret", () => {
    assert.equal(escapeRegex("^start$"), "\\^start\\$");
  });

  it("handles non-special text", () => {
    assert.equal(escapeRegex("hello"), "hello");
  });
});
