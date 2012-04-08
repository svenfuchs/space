require 'ansi/code'

module Space
  module Source
    class Command
      class << self
        def execute(command)
          `#{command}`
        end
      end

      attr_accessor :source, :key, :command

      def initialize(source, key, command)
        @source = source
        @key = key
        @command = command
      end

      def refresh
        Thread.new(&method(:run))
      end

      private

        def run
          chain.call
        rescue Exception => e
          log e.message, e.backtrace
        end

        def chain
          @chain ||= filters.reverse.inject(method(:execute)) do |chain, method|
            -> { method.call(&chain) }
          end
        end

        def execute
          log "#{File.basename(source.path)} $ #{command}"
          self.class.execute(command)
        end

        def filters
          [
            Events.sources.method(:registered),
            method(:update),
            Thread.method(:exclusive),
            method(:clean),
            method(:chdir),
            ::Bundler.method(:with_clean_env)
          ]
        end

        def update
          source.update(key, yield)
        end

        def clean
          strip_ansi(yield.chomp)
        end

        def chdir(&block)
          Dir.chdir(source.path) { |path| block.call }
        end

        def strip_ansi(string)
          string.gsub(ANSI::Code::PATTERN, '')
        end
    end
  end
end
