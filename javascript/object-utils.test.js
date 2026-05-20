/**
 * Tests for object-utils.js (CommonJS)
 *
 * Run: node --test javascript/object-utils.test.js
 */

const assert = require("node:assert/strict");
const { describe, it } = require("node:test");
const { deepClone, pick, omit, deepMerge, entries } = require("./object-utils.js");

describe("deepClone", () => {
  it("clones a plain object", () => {
    const obj = { a: 1, b: 2 };
    const clone = deepClone(obj);
    assert.deepEqual(clone, obj);
    assert.notStrictEqual(clone, obj);
  });

  it("clones nested objects", () => {
    const obj = { a: { b: { c: 3 } } };
    const clone = deepClone(obj);
    clone.a.b.c = 99;
    assert.equal(obj.a.b.c, 3); // original unchanged
  });

  it("clones arrays", () => {
    const arr = [1, [2, 3]];
    const clone = deepClone(arr);
    clone[1][0] = 99;
    assert.equal(arr[1][0], 2);
  });

  it("clones Date objects", () => {
    const date = new Date("2024-01-01");
    const clone = deepClone(date);
    assert.notStrictEqual(clone, date);
    assert.equal(clone.getTime(), date.getTime());
  });

  it("clones RegExp objects", () => {
    const re = /test/gi;
    const clone = deepClone(re);
    assert.notStrictEqual(clone, re);
    assert.equal(clone.source, "test");
    assert.equal(clone.flags, "gi");
  });

  it("clones Maps", () => {
    const map = new Map([["key", "value"]]);
    const clone = deepClone(map);
    clone.set("key", "changed");
    assert.equal(map.get("key"), "value");
  });

  it("clones Sets", () => {
    const set = new Set([1, 2, 3]);
    const clone = deepClone(set);
    clone.add(4);
    assert.equal(set.size, 3);
  });

  it("returns primitives as-is", () => {
    assert.equal(deepClone(42), 42);
    assert.equal(deepClone("hello"), "hello");
    assert.equal(deepClone(null), null);
    assert.equal(deepClone(undefined), undefined);
  });
});

describe("pick", () => {
  it("picks specified keys", () => {
    assert.deepEqual(pick({ a: 1, b: 2, c: 3 }, ["a", "c"]), { a: 1, c: 3 });
  });

  it("ignores missing keys", () => {
    assert.deepEqual(pick({ a: 1 }, ["a", "b"]), { a: 1 });
  });

  it("returns empty object for no matching keys", () => {
    assert.deepEqual(pick({ a: 1 }, ["b"]), {});
  });
});

describe("omit", () => {
  it("omits specified keys", () => {
    assert.deepEqual(omit({ a: 1, b: 2, c: 3 }, ["b"]), { a: 1, c: 3 });
  });

  it("returns full object when no keys omitted", () => {
    assert.deepEqual(omit({ a: 1 }, []), { a: 1 });
  });

  it("returns empty object when all keys omitted", () => {
    assert.deepEqual(omit({ a: 1 }, ["a"]), {});
  });
});

describe("deepMerge", () => {
  it("merges simple objects", () => {
    assert.deepEqual(deepMerge({ a: 1 }, { b: 2 }), { a: 1, b: 2 });
  });

  it("overwrites values", () => {
    assert.deepEqual(deepMerge({ a: 1 }, { a: 2 }), { a: 2 });
  });

  it("deep merges nested objects", () => {
    const result = deepMerge({ a: { b: 1, c: 2 } }, { a: { b: 10, d: 3 } });
    assert.deepEqual(result, { a: { b: 10, c: 2, d: 3 } });
  });

  it("does not mutate source", () => {
    const target = { a: 1 };
    deepMerge(target, { b: 2 });
    assert.deepEqual(target, { a: 1 });
  });
});

describe("entries", () => {
  it("returns key-value pairs", () => {
    assert.deepEqual(entries({ a: 1, b: 2 }), [["a", 1], ["b", 2]]);
  });

  it("handles empty object", () => {
    assert.deepEqual(entries({}), []);
  });
});
