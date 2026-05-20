using Xunit;
using TinyUtils;

namespace TinyUtils.Tests;

public class StringExtensionsTests
{
    [Fact]
    public void Slugify_RemovesSpecialChars()
    {
        Assert.Equal("hello-world", "Hello World!".Slugify());
    }

    [Fact]
    public void Slugify_HandlesMultipleSpaces()
    {
        Assert.Equal("hello-world", "hello   world".Slugify());
    }

    [Fact]
    public void Slugify_TrimsHyphens()
    {
        Assert.Equal("hello-world", "-hello world-".Slugify());
    }

    [Fact]
    public void Slugify_EmptyReturnsEmpty()
    {
        Assert.Equal("", "".Slugify());
    }

    [Fact]
    public void Truncate_AtWordBoundary()
    {
        Assert.Equal("hello...", "hello world foo".Truncate(8));
    }

    [Fact]
    public void Truncate_NoTruncationNeeded()
    {
        Assert.Equal("hello", "hello".Truncate(10));
    }

    [Fact]
    public void Truncate_CustomSuffix()
    {
        Assert.Equal("hello..", "hello world foo".Truncate(8, ".."));
    }

    [Fact]
    public void Truncate_NoWordBoundary()
    {
        Assert.Equal("abcde...", "abcdefghij".Truncate(5));
    }

    [Fact]
    public void Truncate_NullReturnsNull()
    {
        string? s = null;
        Assert.Null(s.Truncate(5));
    }
}

public class MathExtensionsTests
{
    [Fact]
    public void Clamp_InRange()
    {
        Assert.Equal(5.0, 5.0.Clamp(0.0, 10.0));
    }

    [Fact]
    public void Clamp_BelowLowerBound()
    {
        Assert.Equal(0.0, (-1.0).Clamp(0.0, 10.0));
    }

    [Fact]
    public void Clamp_AboveUpperBound()
    {
        Assert.Equal(10.0, 15.0.Clamp(0.0, 10.0));
    }

    [Fact]
    public void Lerp_Start()
    {
        Assert.Equal(10.0, 10.0.Lerp(20.0, 0.0));
    }

    [Fact]
    public void Lerp_End()
    {
        Assert.Equal(20.0, 10.0.Lerp(20.0, 1.0));
    }

    [Fact]
    public void Lerp_Mid()
    {
        Assert.Equal(15.0, 10.0.Lerp(20.0, 0.5));
    }

    [Fact]
    public void RoundTo_Default()
    {
        Assert.Equal(4.0, 3.7.RoundTo(0));
    }

    [Fact]
    public void RoundTo_Decimals()
    {
        Assert.Equal(3.14, 3.14159.RoundTo(2));
    }

    [Fact]
    public void Percentage_Basic()
    {
        Assert.Equal(25.0, 25.0.PercentageOf(100.0));
    }

    [Fact]
    public void Percentage_ZeroTotal()
    {
        Assert.Equal(0.0, 10.0.PercentageOf(0.0));
    }

    [Fact]
    public void Average_Basic()
    {
        Assert.Equal(3.0, MathExtensions.Average(1.0, 2.0, 3.0, 4.0, 5.0));
    }

    [Fact]
    public void Average_Empty()
    {
        Assert.Equal(0.0, MathExtensions.Average());
    }

    [Fact]
    public void Average_Single()
    {
        Assert.Equal(42.0, MathExtensions.Average(42.0));
    }
}
