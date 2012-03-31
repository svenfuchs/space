module Space
  module Commands
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def result(command, args = {})
      commands[command].result(args)
    end

    def commands
      @commands ||= Hash[*self.class::COMMANDS.map do |key, cmd|
        [key, Command.new(path, cmd)]
      end.flatten]
    end

    def reset
      commands.each { |key, command| command.reset }
    end
  end
end
