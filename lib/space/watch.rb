require 'rb-fsevent'

module Space
  class Watch
    attr_reader :path, :callback

    def initialize(path, &block)
      @path  = path
      @callback = block
      run
    end

    def run
      Thread.new { watch }
    end

    private

      def watch
        fsevent.watch(path, file: file?, &callback)
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

