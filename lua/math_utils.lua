--[[
math_utils.lua — Math transformation utilities (Lua)

Pure functions — no side effects, no global state.
--]]

-- ---------------------------------------------------------------------------
-- Clamp
-- ---------------------------------------------------------------------------

--- Clamp a value between a lower and upper bound (inclusive).
function clamp(value, low, high)
  return math.max(low, math.min(high, value))
end

-- ---------------------------------------------------------------------------
-- Lerp
-- ----------------------------------------------------------------------------

--- Linear interpolation between a and b by t [0..1].
function lerp(a, b, t)
  return a + (b - a) * clamp(t, 0, 1)
end

-- ---------------------------------------------------------------------------
-- Round
-- ----------------------------------------------------------------------------

--- Round a number to a specified number of decimal places.
function round(value, decimals)
  decimals = decimals or 0
  local factor = 10 ^ decimals
  return math.floor(value * factor + 0.5) / factor
end

-- ---------------------------------------------------------------------------
-- Average
-- ----------------------------------------------------------------------------

--- Return the arithmetic mean of a table of numbers.
function average(values)
  if #values == 0 then return 0 end
  local sum = 0
  for _, v in ipairs(values) do sum = sum + v end
  return sum / #values
end

-- ---------------------------------------------------------------------------
-- Percentage
-- ----------------------------------------------------------------------------

--- Calculate the percentage that `part` represents of `total`.
function percentage(part, total)
  if total == 0 then return 0 end
  return round((part / total) * 100, 2)
end

return { clamp = clamp, lerp = lerp, round = round, average = average, percentage = percentage }
