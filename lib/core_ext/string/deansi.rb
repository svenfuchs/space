require 'ansi/core'

class String
  def deansi
    gsub(/\e\[[\d]+(?:;[\d]+)?m/, '')
  end
end
