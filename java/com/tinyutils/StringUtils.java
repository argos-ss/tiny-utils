package com.tinyutils;

import java.util.regex.Pattern;

/** Immutable string transformation utilities. Every method is pure. */
public final class StringUtils {

    private static final Pattern NON_WORD = Pattern.compile("[^\\w\\s-]");
    private static final Pattern SPACES = Pattern.compile("[-\\s]+");

    private StringUtils() {}

    /** URL-safe slug from free-form text. */
    public static String slugify(String text) {
        if (text == null || text.isEmpty()) return "";
        String s = text.toLowerCase().trim();
        s = NON_WORD.matcher(s).replaceAll("");
        s = SPACES.matcher(s).replaceAll("-");
        return s.replaceAll("^-+|-+$", "");
    }

    /** Truncate at word boundary. */
    public static String truncate(String text, int maxLen, String suffix) {
        if (text == null || text.length() <= maxLen) return text;
        int space = text.substring(0, maxLen).lastIndexOf(' ');
        return (space > 0 ? text.substring(0, space) : text.substring(0, maxLen)) + suffix;
    }

    public static String truncate(String text, int maxLen) { return truncate(text, maxLen, "..."); }
}
