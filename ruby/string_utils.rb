# frozen_string_literal: true

module StringUtils
  module_function

  def slugify(text)
    text.downcase.strip
        .gsub(/[^\w\s-]/, "")
        .gsub(/[-\s]+/, "-")
        .gsub(/\A-+|-\z/, "")
  end

  def truncate(text, max_len: 80, suffix: "...")
    return text if text.length <= max_len
    truncated = text[0, max_len]
    if (space = truncated.rindex(" "))
      truncated[0, space] + suffix
    else
      truncated + suffix
    end
  end
end
  def palindrome?(text)
    cleaned = text.downcase.gsub(/[^a-z0-9]/, "")
    cleaned == cleaned.reverse
  end
  def palindrome?(text)
    cleaned = text.downcase.gsub(/[^a-z0-9]/, "")
    cleaned == cleaned.reverse
  end
