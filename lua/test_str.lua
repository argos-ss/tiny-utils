-- Tests for str.lua
-- Run: lua lua/test_str.lua

local str = require("str")
local tests = 0
local passed = 0

local function assert(condition, msg)
  tests = tests + 1
  if condition then
    passed = passed + 1
  else
    io.stderr:write("FAIL: " .. msg .. "\n")
  end
end

-- slugify
assert(str.slugify("Hello World!") == "hello-world", "slugify basic")
assert(str.slugify("Hello @#$ World!!!") == "hello-world", "slugify special chars")
assert(str.slugify("hello   world") == "hello-world", "slugify multiple spaces")
assert(str.slugify("-hello world-") == "hello-world", "slugify trim hyphens")
assert(str.slugify("") == "", "slugify empty")

-- truncate
assert(str.truncate("hello", 10) == "hello", "truncate no truncation")
assert(str.truncate("hello world foo", 8) == "hello...", "truncate at boundary")
assert(str.truncate("hello world foo", 8, "..") == "hello..", "truncate custom suffix")
assert(str.truncate("abcdefghij", 5) == "abcde...", "truncate no boundary")
assert(str.truncate("hello", 5) == "hello", "truncate exact")

-- is_palindrome
assert(str.is_palindrome("racecar") == true, "palindrome true")
assert(str.is_palindrome("hello") == false, "palindrome false")
assert(str.is_palindrome("A man a plan a canal panama") == true, "palindrome with spaces")
assert(str.is_palindrome("") == true, "palindrome empty")

io.write(string.format("str: %d/%d passed\n", passed, tests))
os.exit(passed == tests and 0 or 1)
