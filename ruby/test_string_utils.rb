# frozen_string_literal: true

require 'minitest/autorun'
require_relative './string_utils'

class StringUtilsTest < Minitest::Test
  # --- slugify ---

  def test_slugify_basic
    assert_equal 'hello-world', StringUtils.slugify('Hello World!')
  end

  def test_slugify_special_chars
    assert_equal 'hello-world', StringUtils.slugify('Hello @#$ World!!!')
  end

  def test_slugify_multiple_spaces
    assert_equal 'hello-world', StringUtils.slugify('hello   world')
  end

  def test_slugify_trim_hyphens
    assert_equal 'hello-world', StringUtils.slugify('-hello world-')
  end

  def test_slugify_empty
    assert_equal '', StringUtils.slugify('')
  end

  # --- truncate ---

  def test_truncate_no_truncation
    assert_equal 'hello', StringUtils.truncate('hello', max_len: 10)
  end

  def test_truncate_at_boundary
    assert_equal 'hello...', StringUtils.truncate('hello world foo', max_len: 8)
  end

  def test_truncate_custom_suffix
    assert_equal 'hello..', StringUtils.truncate('hello world foo', max_len: 8, suffix: '..')
  end

  def test_truncate_no_word_boundary
    assert_equal 'abcde...', StringUtils.truncate('abcdefghij', max_len: 5)
  end

  def test_truncate_exact
    assert_equal 'hello', StringUtils.truncate('hello', max_len: 5)
  end
end
