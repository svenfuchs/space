class String
  def demodulize
    split('::').last
  end unless method_defined?(:demodulize)
end
