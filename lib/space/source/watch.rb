require 'rb-fsevent'

module Space
  module Source
    class Watch
      LATENCY = 0.1
      NO_DEFER = FALSE

      attr_reader :path, :callback, :suspended, :fsevent

      def initialize(path, &block)
        @path = File.expand_path(path)
        @callback = block
        # @suspended = []
        @fsevent = FSEvent.new
      end

      def run
        @thread = Thread.new do
          log "WATCHING #{path}"
          watch
        end
        self
      end

      # def suspended?
      #   !suspended.empty?
      # end

      # def suspend
      #   suspended << true
      # end

      # def unsuspend
      #   suspended.pop
      # end

      private

        def watch
          fsevent.watch(path, file: file?, latency: LATENCY, no_defer: NO_DEFER) do |paths|
            unless git_dir?(paths)
              log "=> WATCH triggered: #{paths.inspect}"
              fsevent.stop
              callback.call(paths)
              fsevent.run
            end
          end
          fsevent.run
        rescue Exception => e
          puts e.message, e.backtrace
        end

        def file?
          File.file?(path)
        end

        def git_dir?(paths)
          paths.size == 1 && File.basename(paths.first) == '.git'
        end
    end
  end
end

