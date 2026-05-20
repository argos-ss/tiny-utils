/**
 * Tests for math-utils.ts
 *
 * Run: npx vitest run typescript/math-utils.test.ts
 */
import { describe, it, expect } from "vitest";
import { clamp, lerp, roundTo, percentage, average, median } from "./math-utils";

describe("clamp", () => {
  it("returns value within range", () => expect(clamp(5, 0, 10)).toBe(5));
  it("clamps below lower bound", () => expect(clamp(-1, 0, 10)).toBe(0));
  it("clamps above upper bound", () => expect(clamp(15, 0, 10)).toBe(10));
  it("handles equal bounds", () => expect(clamp(5, 5, 5)).toBe(5));
});

describe("lerp", () => {
  it("returns a when t=0", () => expect(lerp(10, 20, 0)).toBe(10));
  it("returns b when t=1", () => expect(lerp(10, 20, 1)).toBe(20));
  it("returns midpoint when t=0.5", () => expect(lerp(10, 20, 0.5)).toBe(15));
  it("clamps t outside [0,1]", () => {
    expect(lerp(10, 20, -0.5)).toBe(10);
    expect(lerp(10, 20, 1.5)).toBe(20);
  });
});

describe("roundTo", () => {
  it("rounds to integer by default", () => expect(roundTo(3.7)).toBe(4));
  it("rounds to specified decimals", () => expect(roundTo(3.14159, 2)).toBe(3.14));
  it("rounds up", () => expect(roundTo(2.5)).toBe(3));
  it("rounds down", () => expect(roundTo(2.4)).toBe(2));
});

describe("percentage", () => {
  it("calculates percentage", () => expect(percentage(25, 100)).toBe(25));
  it("returns 0 when total is 0", () => expect(percentage(10, 0)).toBe(0));
  it("handles decimals", () => expect(percentage(1, 3)).toBe(33.33));
});

describe("average", () => {
  it("calculates average", () => expect(average([1, 2, 3, 4, 5])).toBe(3));
  it("returns 0 for empty array", () => expect(average([])).toBe(0));
  it("handles single value", () => expect(average([42])).toBe(42));
  it("handles decimals", () => expect(average([1.5, 2.5])).toBe(2));
});

describe("median", () => {
  it("odd length", () => expect(median([3, 1, 2])).toBe(2));
  it("even length", () => expect(median([1, 2, 3, 4])).toBe(2.5));
  it("returns 0 for empty array", () => expect(median([])).toBe(0));
  it("single element", () => expect(median([42])).toBe(42));
  it("sorted already", () => expect(median([1, 2, 3])).toBe(2));
});
