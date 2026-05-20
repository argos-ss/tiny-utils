/**
 * Tests for array-utils.js
 *
 * Run: node --test javascript/array-utils.test.js
 */

import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { chunk, shuffle, groupBy, dedupe, zip } from "./array-utils.js";

describe("chunk", () => {
  it("splits array into chunks", () => {
    assert.deepEqual([...chunk([1, 2, 3, 4, 5], 2)], [[1, 2], [3, 4], [5]]);
  });

  it("handles exact division", () => {
    assert.deepEqual([...chunk([1, 2, 3, 4], 2)], [[1, 2], [3, 4]]);
  });

  it("handles size larger than array", () => {
    assert.deepEqual([...chunk([1, 2], 10)], [[1, 2]]);
  });

  it("handles empty array", () => {
    assert.deepEqual([...chunk([], 3)], []);
  });

  it("throws on invalid size", () => {
    assert.throws(() => [...chunk([1, 2], 0)], RangeError);
  });
});

describe("shuffle", () => {
  it("returns array of same length", () => {
    const input = [1, 2, 3, 4, 5];
    const result = shuffle(input);
    assert.equal(result.length, input.length);
  });

  it("does not mutate original", () => {
    const input = [1, 2, 3];
    const copy = [...input];
    shuffle(input);
    assert.deepEqual(input, copy);
  });

  it("contains all original elements", () => {
    const input = [1, 2, 3, 4, 5];
    const result = shuffle(input);
    assert.deepEqual(result.sort((a, b) => a - b), input);
  });
});

describe("groupBy", () => {
  it("groups by key function", () => {
    const items = [
      { category: "fruit", name: "apple" },
      { category: "fruit", name: "banana" },
      { category: "veg", name: "carrot" },
    ];
    const result = groupBy(items, (x) => x.category);
    assert.equal(result.size, 2);
    assert.equal(result.get("fruit").length, 2);
    assert.equal(result.get("veg").length, 1);
  });

  it("handles empty array", () => {
    const result = groupBy([], (x) => x);
    assert.equal(result.size, 0);
  });
});

describe("dedupe", () => {
  it("removes duplicates preserving order", () => {
    assert.deepEqual(dedupe([1, 2, 2, 3, 3, 3, 4]), [1, 2, 3, 4]);
  });

  it("handles array without duplicates", () => {
    assert.deepEqual(dedupe([1, 2, 3]), [1, 2, 3]);
  });

  it("uses key function", () => {
    const items = [{ id: 1 }, { id: 2 }, { id: 1 }];
    assert.deepEqual(dedupe(items, (x) => x.id), [{ id: 1 }, { id: 2 }]);
  });

  it("handles empty array", () => {
    assert.deepEqual(dedupe([]), []);
  });
});

describe("zip", () => {
  it("zips multiple arrays", () => {
    assert.deepEqual(zip([1, 2], ["a", "b"]), [[1, "a"], [2, "b"]]);
  });

  it("stops at shortest array", () => {
    assert.deepEqual(zip([1, 2, 3], ["a", "b"]), [[1, "a"], [2, "b"]]);
  });

  it("handles single array", () => {
    assert.deepEqual(zip([1, 2]), [[1], [2]]);
  });
});
