# frozen_string_literal: true

# String transformation helpers.
# Every method returns a new String — no mutation.
module StringUtils
  module_function

  # URL‑safe slug from arbitrary text.
  def slugify(text)
    text.downcase.strip
        .gsub(/[^\w\s-]/, "")
        .gsub(/[-\s]+/, "-")
        .gsub(/\A-+|-\z/, "")
  end

  # Truncate at word boundary.
  def truncate(text, max_len: 80, suffix: "...")
    return text if text.length <= max_len
    truncated = text[0, max_len]
    if (space = truncated.rindex(" "))
      truncated[0, space] + suffix
    else
      truncated + suffix
    end
  end

  # Capitalize every word (title case).
  def titleize(text)
    text.split.map(&:capitalize).join(" ")
  end
end
