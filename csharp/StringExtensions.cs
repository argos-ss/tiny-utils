using System.Text.RegularExpressions;

namespace TinyUtils;

public static class StringExtensions {
    [GeneratedRegex(@"[^\w\s-]")] private static partial Regex NonWord();
    [GeneratedRegex(@"[\-\s]+")] private static partial Regex Spaces();

    public static string Slugify(this string text) {
        var s = text.ToLowerInvariant().Trim();
        s = NonWord().Replace(s, "");
        s = Spaces().Replace(s, "-");
        return s.Trim('-');
    }

    public static string Truncate(this string text, int maxLen = 80, string suffix = "...") {
        if (string.IsNullOrEmpty(text) || text.Length <= maxLen) return text;
        var truncated = text[..maxLen];
        var lastSpace = truncated.LastIndexOf(' ');
        return (lastSpace > 0 ? truncated[..lastSpace] : truncated) + suffix;
    }
    public static string Reverse(string text) => new string(text.Reverse().ToArray());
    public static string Reverse(string text) => new string(text.Reverse().ToArray());
    public static string Reverse(string text) => new string(text.Reverse().ToArray());
    public static string Reverse(string text) => new string(text.Reverse().ToArray());
}
public static string ReverseExt(this string text) => new string(text.Reverse().ToArray());
public static string ReverseExt(this string text) => new string(text.Reverse().ToArray());
public static string ReverseExt(this string text) => new string(text.Reverse().ToArray());
public static string ReverseExt(this string text) => new string(text.Reverse().ToArray());
