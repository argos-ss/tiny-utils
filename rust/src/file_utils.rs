/// File utility functions — path manipulation, extension checks, size formatting.
use std::path::Path;

/// Check whether a path has one of the given extensions.
///
/// # Examples
///
/// ```
/// assert!(has_extension("main.rs", &["rs"]));
/// assert!(!has_extension("main.rs", &["py", "go"]));
/// ```
pub fn has_extension(path: &str, exts: &[&str]) -> bool {
    let p = Path::new(path);
    match p.extension() {
        Some(e) => exts.contains(&e.to_str().unwrap_or("")),
        None => false,
    }
}

/// Format a byte count into a human-readable string (B/KB/MB/GB).
///
/// # Examples
///
/// ```
/// assert_eq!(format_size(0), "0 B");
/// assert_eq!(format_size(1024), "1.0 KB");
/// assert_eq!(format_size(1_048_576), "1.0 MB");
/// ```
pub fn format_size(bytes: u64) -> String {
    const UNITS: &[&str] = &["B", "KB", "MB", "GB", "TB"];
    let mut size = bytes as f64;
    let mut unit_idx = 0;
    while size >= 1024.0 && unit_idx < UNITS.len() - 1 {
        size /= 1024.0;
        unit_idx += 1;
    }
    if unit_idx == 0 {
        format!("{} {}", bytes, UNITS[unit_idx])
    } else {
        format!("{:.1} {}", size, UNITS[unit_idx])
    }
}

/// Returns the file name portion of a path, or an empty string if there is none.
pub fn filename(path: &str) -> String {
    Path::new(path)
        .file_name()
        .map(|s| s.to_string_lossy().to_string())
        .unwrap_or_default()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_has_extension() {
        assert!(has_extension("script.py", &["py"]));
        assert!(!has_extension("script.py", &["rs", "go"]));
        assert!(!has_extension("noext", &["txt"]));
    }

    #[test]
    fn test_format_size() {
        assert_eq!(format_size(0), "0 B");
        assert_eq!(format_size(500), "500 B");
        assert_eq!(format_size(1024), "1.0 KB");
        assert_eq!(format_size(2_097_152), "2.0 MB");
    }

    #[test]
    fn test_filename() {
        assert_eq!(filename("/path/to/file.rs"), "file.rs");
        assert_eq!(filename("just_name.txt"), "just_name.txt");
        assert_eq!(filename("/"), "");
    }
}
