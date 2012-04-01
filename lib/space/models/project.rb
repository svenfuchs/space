require 'observer'

module Space
  class Project
    include Watcher, Observable, Commands

    COMMANDS = {
      config: 'bundle config'
    }

    WATCH = [
      '.bundle/config'
    ]

    attr_reader :repos

    def initialize(repos)
      @repos = repos
      super('.')
    end

    def local_repos
      config.keys.map do |key|
        key =~ /^local\.(.+)$/
        $1 if repos.names.include?($1)
      end.compact
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
