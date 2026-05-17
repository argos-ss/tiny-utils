using System.Text.RegularExpressions;

namespace TinyUtils;

/// <summary>
/// Extension methods for <see cref="string"/> — pure, chainable.
/// </summary>
public static class StringExtensions
{
    private static readonly Regex NonWord = MyRegex();
    private static readonly Regex Spaces  = MyRegex1();

    [GeneratedRegex(@"[^\w\s-]")]
    private static partial Regex MyRegex();
    [GeneratedRegex(@"[\-\s]+")]
    private static partial Regex MyRegex1();

    /// <summary>URL‑safe slug from free text.</summary>
    public static string Slugify(this string text)
    {
        var s = text.ToLowerInvariant().Trim();
        s = NonWord.Replace(s, "");
        s = Spaces.Replace(s, "-");
        return s.Trim('-');
    }

    /// <summary>Truncate at the nearest word boundary.</summary>
    public static string Truncate(this string text, int maxLen = 80, string suffix = "...")
    {
        if (string.IsNullOrEmpty(text) || text.Length <= maxLen) return text;
        var truncated = text[..maxLen];
        var lastSpace = truncated.LastIndexOf(' ');
        return (lastSpace > 0 ? truncated[..lastSpace] : truncated) + suffix;
    }
}
