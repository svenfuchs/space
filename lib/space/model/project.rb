module Space
  module Model
    class Project
      autoload :Bundler, 'space/model/project/bundler'
      autoload :Tmux,    'space/model/project/tmux'

      include Events

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
        [bundler, repos].each(&:refresh)
      end
    end
  end
end
