require 'bundler'
require 'open3'
require 'core_ext/string/deansi'

module Space
  module Source
    class Command
      class << self
        def execute(dir, command)
          log "#{File.basename(dir)} $ #{command}"
          Open3.capture2e("cd #{dir}; #{command}").first
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
          self.class.execute(source.path, command)
        end

        def filters
          [
            Events.sources.method(:registered),
            method(:update),
            method(:clean),
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
          string.deansi
        end
    end
  end
end
