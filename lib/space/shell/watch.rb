require 'rb-fsevent'

module Space
  module Shell
    class Watch
      LATENCY = 0
      NO_DEFER = FALSE

      attr_reader :path, :callback, :mutex

      def initialize(path, &block)
        @path = File.expand_path(path)
        @callback = block
        @mutex = Mutex.new
        self
      end

      def run
        Thread.new do
          watch
        end
      end

      private

        def watch
          fsevent.watch(path, file: file?, latency: LATENCY, no_defer: NO_DEFER) do |paths|
            fsevent.stop
            mutex.synchronize do
              callback.call(paths)
            end
            fsevent.run
          end
          fsevent.run
        rescue Exception => e
          puts e.message, e.backtrace
        end

        def file?
          File.file?(path)
        end

        def fsevent
          @fsevent ||= FSEvent.new
        end
    end
  end
end
