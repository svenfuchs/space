require 'ansi/core'

class String
  def deansi
    gsub(ANSI::Code::PATTERN, '')
  end
end
