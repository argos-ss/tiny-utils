local str = {}

function str.slugify(text)
  local s = text:lower():match("^%s*(.-)%s*$")
  s = s:gsub("[^%w%s-]", "")
  s = s:gsub("[%s-]+", "-")
  return s:match("^-+(.-)") or s
end

function str.truncate(text, max_len, suffix)
  max_len = max_len or 80
  suffix = suffix or "..."
  if #text <= max_len then return text end
  local truncated = text:sub(1, max_len)
  local last_space = truncated:match("^.*()%s")
  if last_space then return truncated:sub(1, last_space - 1) .. suffix end
  return truncated .. suffix
end

return str
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
function str.is_palindrome(text)
  local cleaned = text:lower():gsub("[^%w]", "")
  return cleaned == cleaned:reverse()
end
