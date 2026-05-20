# frozen_string_literal: true

# Array transformation utilities (Ruby).
#
# Pure module — no side effects, no state.
module ArrayUtils
  module_function

  # Split an array into chunks of the given size.
  # The last chunk may be shorter than size.
  def chunk(array, size)
    return [] if size <= 0
    array.each_slice(size).to_a
  end

  # Remove consecutive duplicates from a sorted array.
  def dedupe(array)
    return [] if array.empty?

    result = [array[0]]
    (1...array.length).each do |i|
      result << array[i] if array[i] != array[i - 1]
    end
    result
  end

  # Return a new array containing only elements for which the block returns true.
  def filter(array, &block)
    array.select(&block)
  end

  # Return a Hash grouping elements by the result of the block.
  def group_by(array, &block)
    array.group_by(&block)
  end

  # Return the first element or nil for an empty array.
  def first(array)
    array.first
  end

  # Return all elements except the first.
  def tail(array)
    array.drop(1)
  end

  # Shuffle array using Fisher-Yates (no mutation of input).
  def shuffle(array)
    shuffled = array.dup
    (shuffled.length - 1).downto(1) do |i|
      j = rand(0..i)
      shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    shuffled
  end
end
