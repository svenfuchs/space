require 'ansi/code'

module Space
  class Command
    attr_reader :context, :command

    def initialize(context, command)
      @context = context
      @command = command
    end

    def result
      @result ||= strip_ansi(run)
    end

    def reset
      @result = nil
    end

    private

      def run
        ::Bundler.with_clean_env do
          chdir do
            `#{command.is_a?(Proc) ? context.instance_eval(&command) : command}`
          end
        end
      end

      def chdir(&block)
        Dir.chdir(context.path, &block)
      end

      def strip_ansi(string)
        string.gsub(ANSI::Code::PATTERN, '')
      end
  end
end
