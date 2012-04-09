module Space
  module Source
    autoload :Command, 'space/source/command'
    autoload :Watch,   'space/source/watch'

    module ClassMethods
      def commands(commands = nil)
        commands ? @commands = commands : @commands
      end

      def watch(*paths)
        paths.empty? ? (@paths || []) : (@paths = paths)
      end
    end

    include Events

    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    attr_reader :path, :results

    def initialize(path)
      @path = path
      @results = {}
      watch
    end

    def commands
      @commands ||= self.class.commands.inject({}) do |commands, (key, command)|
        commands.merge(key => Command.new(self, key, command))
      end
    end

    def refresh
      commands.each { |key, command| command.refresh }
    end

    def update(key, result)
      results[key] = result
      notify(:update)
    end

    private

      def result(key)
        results[key] || ''
      end

      def watch
        watchers.map(&:run)
      end

      def watchers
        @watchers ||= watched_paths.map do |path|
          Watch.new(path) { |paths| refresh }
        end
      end

      def watched_paths
        @watched_paths ||= self.class.watch.map do |path|
          path[0, 1] == '~' ? path : "#{self.path}/#{path}"
        end
      end
  end
end
