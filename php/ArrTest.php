<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
 * @covers Arr
 */
class ArrTest extends TestCase
{
    private array $nested;

    protected function setUp(): void
    {
        $this->nested = [
            'user' => [
                'name' => 'Alice',
                'profile' => ['age' => 30, 'city' => 'NYC']
            ],
            'items' => [
                ['id' => 1, 'tag' => 'a'],
                ['id' => 2, 'tag' => 'b'],
                ['id' => 3, 'tag' => 'a'],
            ]
        ];
    }

    // --- get ---

    public function testGetSimpleKey(): void
    {
        $this->assertEquals('Alice', Arr::get($this->nested, 'user.name'));
    }

    public function testGetDeepNested(): void
    {
        $this->assertEquals(30, Arr::get($this->nested, 'user.profile.age'));
    }

    public function testGetMissingKeyReturnsDefault(): void
    {
        $this->assertNull(Arr::get($this->nested, 'user.nonexistent'));
    }

    public function testGetCustomDefault(): void
    {
        $this->assertEquals('fallback', Arr::get($this->nested, 'missing.key', 'fallback'));
    }

    // --- pluck ---

    public function testPluck(): void
    {
        $this->assertEquals([1, 2, 3], Arr::pluck($this->nested['items'], 'id'));
    }

    public function testPluckTags(): void
    {
        $this->assertEquals(['a', 'b', 'a'], Arr::pluck($this->nested['items'], 'tag'));
    }

    public function testPluckEmptyArray(): void
    {
        $this->assertEquals([], Arr::pluck([], 'key'));
    }

    // --- chunk ---

    public function testChunkBasic(): void
    {
        $result = Arr::chunk([1, 2, 3, 4, 5], 2);
        $this->assertCount(3, $result);
        $this->assertEquals([[1, 2], [3, 4], [5]], $result);
    }

    public function testChunkInvalidSize(): void
    {
        $this->assertEquals([], Arr::chunk([1, 2], 0));
    }

    // --- flatten ---

    public function testFlatten(): void
    {
        $this->assertEquals([1, 2, 3, 4], Arr::flatten([1, [2, [3]], 4]));
    }

    public function testFlattenEmpty(): void
    {
        $this->assertEquals([], Arr::flatten([]));
    }

    // --- keyBy ---

    public function testKeyBy(): void
    {
        $result = Arr::keyBy($this->nested['items'], 'id');
        $this->assertCount(3, $result);
        $this->assertArrayHasKey('1', $result);
        $this->assertArrayHasKey('2', $result);
        $this->assertEquals('a', $result['1']['tag']);
    }
}
