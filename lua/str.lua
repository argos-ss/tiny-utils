--- String utilities for Lua.
-- Every function returns a new string.
-- @module str

local str = {}

--- URL-safe slug.
function str.slugify(text)
  local s = text:lower():match("^%s*(.-)%s*$") -- trim
  s = s:gsub("[^%w%s-]", "")
  s = s:gsub("[%s-]+", "-")
  return s:match("^-+(.-)") or s
end

--- Truncate at word boundary.
function str.truncate(text, max_len, suffix)
  max_len = max_len or 80
  suffix = suffix or "..."
  if #text <= max_len then return text end
  local truncated = text:sub(1, max_len)
  local last_space = truncated:match("^.*()%s")
  if last_space then
    return truncated:sub(1, last_space - 1) .. suffix
  end
  return truncated .. suffix
end

--- Capitalize first letter of each word.
function str.titleize(text)
  local result = {}
  for word in text:gmatch("%S+") do
    table.insert(result, word:sub(1,1):upper() .. word:sub(2):lower())
  end
  return table.concat(result, " ")
end

return str
