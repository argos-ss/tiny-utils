package com.tinyutils;

/**
 * Immutable string transformation utilities.
 *
 * <p>Every method returns a new {@link String}; no state is modified.
 */
public final class StringUtils {

    private StringUtils() {} // utility class

    /** Regex used by {@link #slugify(String)}. */
    private static final java.util.regex.Pattern NON_WORD =
        java.util.regex.Pattern.compile("[^\\w\\s-]");

    private static final java.util.regex.Pattern SPACES =
        java.util.regex.Pattern.compile("[-\\s]+");

    /**
     * Converts free text into a URL-safe slug.
     *
     * @param text input, may be {@code null}
     * @return slug or empty string
     */
    public static String slugify(String text) {
        if (text == null || text.isEmpty()) return "";
        String s = text.toLowerCase().trim();
        s = NON_WORD.matcher(s).replaceAll("");
        s = SPACES.matcher(s).replaceAll("-");
        return s.replaceAll("^-+|-+$", "");
    }

    /**
     * Truncates text at the nearest word boundary.
     *
     * @param text     input
     * @param maxLen   hard character limit
     * @param suffix   appended when truncated
     * @return original or truncated string
     */
    public static String truncate(String text, int maxLen, String suffix) {
        if (text == null || text.length() <= maxLen) return text;
        int space = text.substring(0, maxLen).lastIndexOf(' ');
        return (space > 0 ? text.substring(0, space) : text.substring(0, maxLen)) + suffix;
    }

    public static String truncate(String text, int maxLen) {
        return truncate(text, maxLen, "...");
    }
}
