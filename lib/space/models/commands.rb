module Space
  module Commands
    class << self
      def all
        @all ||= []
      end

      def preload
        all.map(&:preload)
      end
    end

    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path)
      Commands.all << self
    end

    def result(command)
      commands[command].result
    end

    def commands
      @commands ||= Hash[*self.class::COMMANDS.map do |key, cmd|
        [key, Command.new(self, cmd)]
      end.flatten]
    end

    def reset
      commands.each { |key, command| command.reset }
    end

    def preload
      commands.each do |key, command|
        print '.'
        command.result
      end
    end
  end
end
