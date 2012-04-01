require 'observer'

module Space
  class Project
    attr_reader :name, :repos, :bundler

    def initialize(name, config)
      @name = name
      @repos = Repos.new(self, config.paths)
      @bundler = Bundler.new
    end

    def names
      @names ||= Tmux.windows || repos.names
    end

    def local_repos
      bundler.config.keys.map do |key|
        key =~ /^local\.(.+)$/
        $1 if repos.names.include?($1)
      end.compact
    end

    def number(name)
      if number = names.index(name)
        number + 1
      else
        names << name
        number(name)
      end
    end

    def add_observer(observer)
      repos.add_observer(observer)
      bundler.add_observer(observer)
    end
  end
end
