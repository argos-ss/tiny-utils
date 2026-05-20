/**
 * Tests for string-utils.ts
 *
 * Run: npx vitest run typescript/string-utils.test.ts
 */
import { describe, it, expect } from "vitest";
import { slugify, truncate, camelToSnake, reverseWords, toPascal } from "./string-utils";

describe("slugify", () => {
  it("converts to lowercase hyphenated slug", () => expect(slugify("Hello World!")).toBe("hello-world"));
  it("removes special characters", () => expect(slugify("Hello @#$ World!!!")).toBe("hello-world"));
  it("handles multiple spaces", () => expect(slugify("hello   world")).toBe("hello-world"));
  it("trims leading/trailing hyphens", () => expect(slugify("-hello world-")).toBe("hello-world"));
  it("handles empty string", () => expect(slugify("")).toBe(""));
});

describe("truncate", () => {
  it("returns original when short enough", () => expect(truncate("hello", 10)).toBe("hello"));
  it("truncates at word boundary", () => expect(truncate("hello world foo", 8)).toBe("hello..."));
  it("handles custom suffix", () => expect(truncate("hello world foo", 8, "..")).toBe("hello.."));
  it("truncates without word boundary", () => expect(truncate("abcdefghij", 5)).toBe("abcde..."));
});

describe("camelToSnake", () => {
  it("converts camelCase", () => expect(camelToSnake("camelCase")).toBe("camel_case"));
  it("converts PascalCase", () => expect(camelToSnake("PascalCase")).toBe("pascal_case"));
  it("handles acronyms", () => expect(camelToSnake("XMLParser")).toBe("xml_parser"));
  it("handles single word", () => expect(camelToSnake("hello")).toBe("hello"));
});

describe("reverseWords", () => {
  it("reverses word order", () => expect(reverseWords("hello world")).toBe("world hello"));
  it("handles multiple words", () => expect(reverseWords("a b c d")).toBe("d c b a"));
  it("handles single word", () => expect(reverseWords("hello")).toBe("hello"));
  it("handles empty", () => expect(reverseWords("")).toBe(""));
});

describe("toPascal", () => {
  it("converts kebab-case", () => expect(toPascal("hello-world")).toBe("HelloWorld"));
  it("converts snake_case", () => expect(toPascal("hello_world")).toBe("HelloWorld"));
  it("handles single word", () => expect(toPascal("hello")).toBe("Hello"));
  it("handles empty", () => expect(toPascal("")).toBe(""));
});
