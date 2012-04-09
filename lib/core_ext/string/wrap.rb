class String
  def wrap(width)
    gsub(/(.{1,#{width}})( +|$\n?)|(.{1,#{width}})/, "\\1\\3\n").chomp
  end unless method_defined?(:wrap)
end
