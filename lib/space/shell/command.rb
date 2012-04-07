require 'ansi/code'

module Space
  module Shell
    class Command
      class << self
        def execute(command)
          `#{command}`
        end
      end

      attr_reader :context, :command, :result

      def initialize(context, command)
        @context = context
        @command = command
      end

      def run
        puts "\nRUNNING #{command} in [#{context.path}]"
        notifying do
          @result = chain.call
        end
      end

      private

        def notifying(&block)
          old = result
          yield.tap do |new|
            puts "UP TO DATE? #{(old == new).inspect}"
            notify unless old == new
          end
        end

        def notify
          context.notify(command, result)
        end

        def chain
          runner = -> { clean(self.class.execute(command)) }
          filters.reverse.inject(runner) { |runner, filter| -> { filter.call(&runner) } }
        end

        def filters
          [method(:chdir), ::Bundler.method(:with_clean_env) ]
        end

        def chdir(&block)
          Dir.chdir(context.path) { |path| block.call }
        end

        def clean(string)
          strip_ansi(string.chomp)
        end

        def strip_ansi(string)
          string.gsub(ANSI::Code::PATTERN, '')
        end
    end
  end
end
