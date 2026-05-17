using Xunit;

namespace TinyUtils.Tests;

public class StringExtensionsTests
{
    [Fact]
    public void Slugify_RemovesSpecialChars()
    {
        Assert.Equal("hello-world", "Hello World!".Slugify());
    }

    [Fact]
    public void Truncate_AtWordBoundary()
    {
        Assert.Equal("hello...", "hello world foo".Truncate(8));
    }
}
