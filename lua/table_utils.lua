--- Collection utilities for Lua.
-- @module table_utils

local tbl = {}

--- Chunk a list into fixed-size groups.
function tbl.chunk(list, size)
  local result = {}
  for i = 1, #list, size do
    local chunk = {}
    for j = i, math.min(i + size - 1, #list) do
      table.insert(chunk, list[j])
    end
    table.insert(result, chunk)
  end
  return result
end

--- Shuffle array in-place (Fisher-Yates).
function tbl.shuffle(list)
  for i = #list, 2, -1 do
    local j = math.random(1, i)
    list[i], list[j] = list[j], list[i]
  end
  return list
end

--- Sum numeric values.
function tbl.sum(list)
  local total = 0
  for _, v in ipairs(list) do total = total + v end
  return total
end

return tbl
