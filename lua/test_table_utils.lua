-- Tests for table_utils.lua
-- Run: lua lua/test_table_utils.lua

local tbl = require("table_utils")
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

-- chunk
local function deep_equal(a, b)
  if #a ~= #b then return false end
  for i = 1, #a do
    if #a[i] ~= #b[i] then return false end
    for j = 1, #a[i] do
      if a[i][j] ~= b[i][j] then return false end
    end
  end
  return true
end

assert(deep_equal(tbl.chunk({1, 2, 3, 4, 5}, 2), {{1, 2}, {3, 4}, {5}}), "chunk basic")
assert(deep_equal(tbl.chunk({1, 2, 3, 4}, 2), {{1, 2}, {3, 4}}), "chunk exact")
assert(deep_equal(tbl.chunk({1, 2}, 10), {{1, 2}}), "chunk larger than list")
assert(#tbl.chunk({}, 3) == 0, "chunk empty")

-- sum
assert(tbl.sum({1, 2, 3, 4, 5}) == 15, "sum basic")
assert(tbl.sum({}) == 0, "sum empty")
assert(tbl.sum({-5, 5}) == 0, "sum negative")

-- shuffle returns a table of same length
local input = {1, 2, 3, 4, 5}
local shuffled = tbl.shuffle({1, 2, 3, 4, 5})
assert(#shuffled == #input, "shuffle same length")

-- all original elements present after shuffle
local sorted = {}
for _, v in ipairs(shuffled) do sorted[v] = true end
for _, v in ipairs(input) do assert(sorted[v], "shuffle contains element " .. v) end

io.write(string.format("table_utils: %d/%d passed\n", passed, tests))
os.exit(passed == tests and 0 or 1)
