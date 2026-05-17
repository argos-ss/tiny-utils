/// String manipulation primitives.

/// Convert free-form text to a URL-safe slug.
pub fn slugify(text: &str) -> String {
    text.to_lowercase()
        .trim()
        .chars()
        .filter(|c| c.is_alphanumeric() || c.is_whitespace() || *c == '-')
        .collect::<String>()
        .split_whitespace()
        .collect::<Vec<_>>()
        .join("-")
}

/// Truncate text at the nearest word boundary.
pub fn truncate(text: &str, max_len: usize) -> String {
    if text.len() <= max_len {
        return text.to_owned();
    }

    let truncated: String = text.chars().take(max_len).collect();
    match truncated.rfind(' ') {
        Some(pos) => format!("{}...", &truncated[..pos]),
        None => format!("{}...", truncated),
    }
}

/// Reverse the order of whitespace-delimited words.
pub fn reverse_words(text: &str) -> String {
    text.split_whitespace()
        .rev()
        .collect::<Vec<_>>()
        .join(" ")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_slugify() {
        assert_eq!(slugify("Hello World!"), "hello-world");
    }

    #[test]
    fn test_truncate_no_cut() {
        assert_eq!(truncate("hi", 10), "hi");
    }

    #[test]
    fn test_truncate_at_boundary() {
        let result = truncate("hello world foo", 12);
        assert!(result.ends_with("..."));
    }

    #[test]
    fn test_reverse_words() {
        assert_eq!(reverse_words("a b c"), "c b a");
    }
}
