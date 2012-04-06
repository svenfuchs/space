module Enumerable
  def map_slice(num, &block)
    result = []
    each_slice(num) { |element| result << yield(element) }
    result
  end unless method_defined?(:map_slice)
end

