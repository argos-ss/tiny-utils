/**
 * Tests for type-utils.ts
 *
 * Run: npx vitest run typescript/type-utils.test.ts
 */
import { describe, it, expect } from "vitest";
import {
  isObject,
  isString,
  isNumber,
  isBoolean,
  isArray,
  isNonEmptyString,
  expectDefined,
} from "./type-utils";

describe("isObject", () => {
  it("returns true for plain objects", () => {
    expect(isObject({})).toBe(true);
    expect(isObject({ a: 1 })).toBe(true);
  });
  it("returns false for arrays", () => expect(isObject([])).toBe(false));
  it("returns false for null", () => expect(isObject(null)).toBe(false));
  it("returns false for primitives", () => {
    expect(isObject("hello")).toBe(false);
    expect(isObject(42)).toBe(false);
    expect(isObject(true)).toBe(false);
  });
});

describe("isString", () => {
  it("returns true for strings", () => expect(isString("hello")).toBe(true));
  it("returns false for non-strings", () => {
    expect(isString(42)).toBe(false);
    expect(isString(true)).toBe(false);
    expect(isString(null)).toBe(false);
    expect(isString({})).toBe(false);
  });
});

describe("isNumber", () => {
  it("returns true for numbers", () => {
    expect(isNumber(42)).toBe(true);
    expect(isNumber(0)).toBe(true);
    expect(isNumber(-3.14)).toBe(true);
  });
  it("returns false for NaN", () => expect(isNumber(NaN)).toBe(false));
  it("returns false for non-numbers", () => {
    expect(isNumber("42")).toBe(false);
    expect(isNumber(null)).toBe(false);
  });
});

describe("isBoolean", () => {
  it("returns true for booleans", () => {
    expect(isBoolean(true)).toBe(true);
    expect(isBoolean(false)).toBe(true);
  });
  it("returns false for non-booleans", () => {
    expect(isBoolean(1)).toBe(false);
    expect(isBoolean("true")).toBe(false);
  });
});

describe("isArray", () => {
  it("returns true for arrays", () => expect(isArray([1, 2, 3])).toBe(true));
  it("returns false for non-arrays", () => {
    expect(isArray({})).toBe(false);
    expect(isArray("hello")).toBe(false);
  });
});

describe("isNonEmptyString", () => {
  it("returns true for non-empty strings", () => expect(isNonEmptyString("hello")).toBe(true));
  it("returns false for empty string", () => expect(isNonEmptyString("")).toBe(false));
  it("returns false for non-strings", () => expect(isNonEmptyString(42)).toBe(false));
});

describe("expectDefined", () => {
  it("passes for defined values", () => {
    expect(() => expectDefined(42, "val")).not.toThrow();
    expect(() => expectDefined("hello", "val")).not.toThrow();
    expect(() => expectDefined(false, "val")).not.toThrow();
  });
  it("throws for null", () => expect(() => expectDefined(null, "val")).toThrow("val"));
  it("throws for undefined", () => expect(() => expectDefined(undefined, "val")).toThrow("val"));
});
