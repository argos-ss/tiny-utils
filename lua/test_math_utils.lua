-- Tests for math_utils.lua
-- Run: lua lua/test_math_utils.lua

local math_utils = require("math_utils")
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

-- clamp
assert(math_utils.clamp(5, 0, 10) == 5, "clamp in range")
assert(math_utils.clamp(-1, 0, 10) == 0, "clamp below")
assert(math_utils.clamp(15, 0, 10) == 10, "clamp above")

-- lerp
assert(math_utils.lerp(10, 20, 0) == 10, "lerp t=0")
assert(math_utils.lerp(10, 20, 1) == 20, "lerp t=1")
assert(math_utils.lerp(10, 20, 0.5) == 15, "lerp t=0.5")
assert(math_utils.lerp(10, 20, -0.5) == 10, "lerp clamps low")
assert(math_utils.lerp(10, 20, 1.5) == 20, "lerp clamps high")

-- round
assert(math_utils.round(3.7) == 4, "round up")
assert(math_utils.round(3.2) == 3, "round down")
assert(math_utils.round(3.14159, 2) == 3.14, "round to 2 decimals")
assert(math_utils.round(3.0) == 3, "round exact")

-- average
assert(math_utils.average({1, 2, 3, 4, 5}) == 3, "average basic")
assert(math_utils.average({}) == 0, "average empty")
assert(math_utils.average({42}) == 42, "average single")

-- percentage
assert(math_utils.percentage(25, 100) == 25, "percentage basic")
assert(math_utils.percentage(10, 0) == 0, "percentage zero total")
assert(math_utils.percentage(1, 3) == 33.33, "percentage fractional")

io.write(string.format("math_utils: %d/%d passed\n", passed, tests))
os.exit(passed == tests and 0 or 1)
