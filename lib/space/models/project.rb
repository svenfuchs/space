module Space
  module Models
    class Project
      include Events

      autoload :Bundler, 'space/models/project/bundler'

      attr_reader :name, :repos, :bundler, :config

      def initialize(name)
        @name    = name
        @config  = Config.load(name)
        @repos   = Repos.new(self, config.paths)
        @bundler = Bundler.new(self)
      end

      def local_repos
        bundler.config.keys.map do |key|
          key =~ /^local\.(.+)$/
          $1 if repos.names.include?($1)
        end.compact
      end

      def names
        @names ||= Tmux.windows || repos.names
      end

      def number(name)
        if number = names.index(name)
          number + 1
        else
          names << name
          number(name)
        end
      end

      def refresh
        bundler.refresh
        repos.all.each(&:refresh)
      end

      def subscribe(*args)
        super
        [bundler, repos].each { |object| object.subscribe(self) }
      end
    end
  end
end
