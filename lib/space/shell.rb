module Space
  module Shell
    autoload :Command, 'space/shell/command'
    autoload :Watch,   'space/shell/watch'
    autoload :Watcher, 'space/shell/watcher'

    module ClassMethods
      def commands(commands = nil)
        commands ? @commands = commands : @commands
      end

      def watch(paths = nil)
        paths ? @paths = paths : @paths
      end
    end

    include Watcher

    class << self
      def included(base)
        base.extend(ClassMethods)
      end

      def all
        @all ||= []
      end

      def refresh
        all.map(&:refresh)
      end
    end

    attr_reader :path

    def initialize(path = '.')
      @path = File.expand_path(path)
      Shell.all << self
      super
    end

    def result(command)
      commands[command].result
    end

    def commands
      @commands ||= self.class.commands.inject({}) do |commands, (key, command)|
        commands.merge(key => Command.new(self, command))
      end
    end

    def refresh
      commands.each { |key, command| command.run }
      notify(:refresh, nil)
    end
  end
end
