# frozen_string_literal: true

require 'minitest/autorun'
require_relative './array_utils'

class ArrayUtilsTest < Minitest::Test
  # --- chunk ---

  def test_chunk_basic
    assert_equal [[1, 2], [3, 4], [5]], ArrayUtils.chunk([1, 2, 3, 4, 5], 2)
  end

  def test_chunk_exact
    assert_equal [[1, 2], [3, 4]], ArrayUtils.chunk([1, 2, 3, 4], 2)
  end

  def test_chunk_larger_than_array
    assert_equal [[1, 2]], ArrayUtils.chunk([1, 2], 10)
  end

  def test_chunk_invalid_size
    assert_equal [], ArrayUtils.chunk([1, 2], 0)
  end

  def test_chunk_empty
    assert_equal [], ArrayUtils.chunk([], 3)
  end

  # --- dedupe ---

  def test_dedupe_basic
    assert_equal [1, 2, 3, 4], ArrayUtils.dedupe([1, 1, 2, 3, 3, 3, 4])
  end

  def test_dedupe_no_duplicates
    assert_equal [1, 2, 3], ArrayUtils.dedupe([1, 2, 3])
  end

  def test_dedupe_empty
    assert_equal [], ArrayUtils.dedupe([])
  end

  # --- filter ---

  def test_filter
    result = ArrayUtils.filter([1, 2, 3, 4, 5]) { |x| x > 3 }
    assert_equal [4, 5], result
  end

  def test_filter_empty
    result = ArrayUtils.filter([]) { |x| x }
    assert_equal [], result
  end

  # --- group_by ---

  def test_group_by
    items = %w[apple banana apricot]
    result = ArrayUtils.group_by(items) { |w| w[0] }
    assert_equal %w[apple apricot], result['a']
    assert_equal ['banana'], result['b']
  end

  # --- first ---

  def test_first
    assert_equal 1, ArrayUtils.first([1, 2, 3])
  end

  def test_first_empty
    assert_nil ArrayUtils.first([])
  end

  # --- tail ---

  def test_tail
    assert_equal [2, 3], ArrayUtils.tail([1, 2, 3])
  end

  def test_tail_single
    assert_equal [], ArrayUtils.tail([1])
  end

  # --- shuffle ---

  def test_shuffle_returns_same_elements
    input = [1, 2, 3, 4, 5]
    result = ArrayUtils.shuffle(input)
    assert_equal input.sort, result.sort
  end

  def test_shuffle_does_not_mutate_original
    input = [1, 2, 3]
    original = input.dup
    ArrayUtils.shuffle(input)
    assert_equal original, input
  end
end
