require 'rb-fsevent'

module Space
  class Watch
    LATENCY = 0
    NO_DEFER = FALSE

    attr_reader :path, :callback

    def initialize(path, &block)
      @path = File.expand_path(path)
      @callback = block
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
          callback.call(paths)
          # sleep(1)
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

