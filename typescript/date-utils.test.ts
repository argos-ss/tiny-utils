/**
 * Tests for date-utils.ts
 *
 * Run: npx vitest run typescript/date-utils.test.ts
 */
import { describe, it, expect } from "vitest";
import { formatDate, daysBetween, addDays, isWeekend, relativeTime, isLeapYear } from "./date-utils";

describe("formatDate", () => {
  it("formats as YYYY-MM-DD by default", () => {
    const d = new Date(2024, 0, 15); // Jan 15, 2024
    expect(formatDate(d)).toBe("2024-01-15");
  });

  it("formats with custom template", () => {
    const d = new Date(2024, 5, 3, 14, 30, 15);
    expect(formatDate(d, "HH:mm:ss")).toBe("14:30:15");
  });

  it("pads single-digit months and days", () => {
    const d = new Date(2024, 0, 1);
    expect(formatDate(d)).toBe("2024-01-01");
  });
});

describe("daysBetween", () => {
  it("calculates days between two dates", () => {
    const a = new Date(2024, 0, 1);
    const b = new Date(2024, 0, 10);
    expect(daysBetween(a, b)).toBe(9);
  });

  it("returns 0 for same date", () => {
    const d = new Date(2024, 0, 1);
    expect(daysBetween(d, d)).toBe(0);
  });

  it("is order-independent", () => {
    const a = new Date(2024, 0, 10);
    const b = new Date(2024, 0, 1);
    expect(daysBetween(a, b)).toBe(9);
  });
});

describe("addDays", () => {
  it("adds positive days", () => {
    const d = new Date(2024, 0, 1);
    const result = addDays(d, 5);
    expect(result.getDate()).toBe(6);
  });

  it("subtracts days", () => {
    const d = new Date(2024, 0, 10);
    const result = addDays(d, -5);
    expect(result.getDate()).toBe(5);
  });

  it("does not mutate original", () => {
    const d = new Date(2024, 0, 1);
    addDays(d, 1);
    expect(d.getDate()).toBe(1);
  });
});

describe("isWeekend", () => {
  it("returns true for Saturday", () => {
    const sat = new Date(2024, 0, 6); // Saturday
    expect(isWeekend(sat)).toBe(true);
  });

  it("returns true for Sunday", () => {
    const sun = new Date(2024, 0, 7); // Sunday
    expect(isWeekend(sun)).toBe(true);
  });

  it("returns false for Monday", () => {
    const mon = new Date(2024, 0, 1); // Monday
    expect(isWeekend(mon)).toBe(false);
  });
});

describe("relativeTime", () => {
  it('returns "just now" for recent times', () => {
    const d = new Date();
    expect(relativeTime(d)).toBe("just now");
  });

  it("returns minutes ago", () => {
    const d = new Date(Date.now() - 5 * 60 * 1000);
    expect(relativeTime(d)).toBe("5m ago");
  });

  it("returns hours ago", () => {
    const d = new Date(Date.now() - 3 * 60 * 60 * 1000);
    expect(relativeTime(d)).toBe("3h ago");
  });

  it("returns days ago", () => {
    const d = new Date(Date.now() - 2 * 24 * 60 * 60 * 1000);
    expect(relativeTime(d)).toBe("2d ago");
  });
});

describe("isLeapYear", () => {
  it("returns true for leap years", () => {
    expect(isLeapYear(2024)).toBe(true);
    expect(isLeapYear(2000)).toBe(true);
  });

  it("returns false for non-leap years", () => {
    expect(isLeapYear(2023)).toBe(false);
    expect(isLeapYear(1900)).toBe(false);
  });
});
