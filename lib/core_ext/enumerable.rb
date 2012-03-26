module Enumerable
  def map_with_index(&block)
    result = []
    each_with_index { |element, ix| result << yield(element, ix) }
    result
  end

  def map_slice(num, &block)
    result = []
    each_slice(num) { |element| result << yield(element) }
    result
  end
end
