require 'ansi/code'

module Space
  class Command
    attr_reader :path, :command

    def initialize(path, command)
      @path = File.expand_path(path)
      @command = command
    end

    def result(args = {})
      @result ||= chdir { strip_ansi(`#{command % args}`) }
    end

    def reset
      @result = nil
    end

    def chdir(&block)
      Dir.chdir(path, &block)
    end

    def strip_ansi(string)
      string.gsub(ANSI::Code::PATTERN, '')
    end
  end
end
