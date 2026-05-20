<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;
use TinyUtils\Str;

/**
 * @covers TinyUtils\Str
 */
class StrTest extends TestCase
{
    // --- slugify ---

    public function testSlugifyBasic(): void
    {
        $this->assertEquals('hello-world', Str::slugify('Hello World!'));
    }

    public function testSlugifySpecialChars(): void
    {
        $this->assertEquals('hello-world', Str::slugify('Hello @#$ World!!!'));
    }

    public function testSlugifyMultipleSpaces(): void
    {
        $this->assertEquals('hello-world', Str::slugify('hello   world'));
    }

    public function testSlugifyTrimHyphens(): void
    {
        $this->assertEquals('hello-world', Str::slugify('-hello world-'));
    }

    public function testSlugifyEmpty(): void
    {
        $this->assertEquals('', Str::slugify(''));
    }

    public function testSlugifyUnicode(): void
    {
        $this->assertEquals('çalışma', Str::slugify('Çalışma!'));
    }

    // --- truncate ---

    public function testTruncateNoTruncation(): void
    {
        $this->assertEquals('hello', Str::truncate('hello', 10));
    }

    public function testTruncateAtWordBoundary(): void
    {
        $this->assertEquals('hello...', Str::truncate('hello world foo', 8));
    }

    public function testTruncateCustomSuffix(): void
    {
        $this->assertEquals('hello..', Str::truncate('hello world foo', 8, '..'));
    }

    public function testTruncateNoWordBoundary(): void
    {
        $this->assertEquals('abcde...', Str::truncate('abcdefghij', 5));
    }

    public function testTruncateExactLength(): void
    {
        $this->assertEquals('hello', Str::truncate('hello', 5));
    }

    public function testTruncateTurkish(): void
    {
        $this->assertEquals(
            'merhaba...',
            Str::truncate('merhaba dünya nasılsın', 10)
        );
    }
}
