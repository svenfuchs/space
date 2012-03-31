module Space
  class Bundle
    include Commands

    COMMANDS = {
      :check  => 'bundle check',
      :list   => 'bundle list | grep %<name>s',
      :config => 'bundle config'
    }

    attr_reader :name, :repos

    def initialize(name, repos, path)
      @name = name
      @repos = repos
      super(path)
    end

    def clean?
      info =~ /dependencies are satisfied/
    end

    def info
      result(:check).split("\n").first
    end

    def deps
      result(:list, :name => name).split("\n").map do |dep|
        matches = dep.strip.match /^\* (?<name>[\S]+) \(\d+\.\d+\.\d+(?: (?<ref>.+))?\)/
        Dependency.new(repos, matches[:name], matches[:ref])
      end.compact
    end

    def local_repos
      config.keys.map do |key|
        key =~ /^local\.(.+)$/ && $1
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
