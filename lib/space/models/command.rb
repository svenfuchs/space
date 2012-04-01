require 'ansi/code'

module Space
  class Command
    attr_reader :path, :command

    def initialize(path, command)
      @path = File.expand_path(path)
      @command = command
    end

    def result(args = {})
      @result ||= strip_ansi(run(args))
    end

    def reset
      @result = nil
    end

    private

      def run(args)
        ::Bundler.with_clean_env do
          chdir do
            `#{command % args}`
          end
        end
      end

      def chdir(&block)
        Dir.chdir(path, &block)
      end

      def strip_ansi(string)
        string.gsub(ANSI::Code::PATTERN, '')
      end
  end
end
