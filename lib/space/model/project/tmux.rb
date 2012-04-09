# TODO make this a source?
#
module Space
  module Model
    class Project
      module Tmux
        class << self
          def windows
            windows = `tmux list-windows -F '#W'`.split("\n")
            windows unless windows.empty?
          end
        end
      end
    end
  end
end
