module Space
  module Tmux
    class << self
      def windows
        windows = `tmux list-windows -F '#W'`.split("\n")
        windows unless windows.empty?
      end
    end
  end
end
