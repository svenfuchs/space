require 'rb-fsevent'

module Space
  module Source
    class Watch
      LATENCY = 0.1
      NO_DEFER = FALSE

      attr_reader :path, :callback, :fsevent

      def initialize(path, &block)
        @path = File.expand_path(path)
        @callback = block
        @fsevent = FSEvent.new
      end

      def run
        @thread = Thread.new do
          log "WATCHING #{path}"
          watch
        end
        self
      end

      private

        def watch
          fsevent.watch(path, file: file?, latency: LATENCY, no_defer: NO_DEFER) do |paths|
            # git touches the .git dir on `git status` as we use this command
            # internally we need to ignore this. as no other relevant action
            # only touches the .git dir, we can just skip it.
            paths.reject!(&method(:git_dir?))

            unless paths.empty?
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

        def git_dir?(path)
          File.basename(path) == '.git'
        end
    end
  end
end

