require 'observer'

module Space
  class Bundler
    include Watcher, Observable, Commands

    COMMANDS = {
      config: 'bundle config'
    }

    WATCH = [
      '.bundle/config'
    ]

    def initialize
      super('.')
    end

    def config
      lines  = result(:config).split("\n")[2..-1]
      values = lines.map_slice(3) do |name, value, _|
        [name, value =~ /: "(.*)"/ && $1]
      end
      Hash[*values.compact.flatten]
    end
  end
end
