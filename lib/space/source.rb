module Space
  module Source
    autoload :Command, 'space/source/command'
    autoload :Watch,   'space/source/watch'
    autoload :Watcher, 'space/source/watcher'

    module ClassMethods
      def commands(commands = nil)
        commands ? @commands = commands : @commands
      end

      def watch(*paths)
        paths.empty? ? (@paths || []) : (@paths = paths)
      end
    end

    include Events, Watcher

    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    attr_reader :results

    def initialize(path)
      @results = {}
      super
    end

    def commands
      @commands ||= self.class.commands.inject({}) do |commands, (key, command)|
        commands.merge(key => Command.new(self, key, command))
      end
    end

    def result(key)
      results[key] || ''
    end

    def refresh
      commands.each { |key, command| command.refresh }
    end

    def update(key, result)
      results[key] = result
      notify(:update)
    end
  end
end
