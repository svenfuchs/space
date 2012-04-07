module Space
  module Shell
    module Watcher
      class << self
        def suspend
          @suspended = true
          yield.tap do
            @suspended = false
          end
        end

        def suspended?
          !!@suspended
        end
      end

      def initialize(*args)
        watch
      end

      private

        def watch
          targets.each do |path|
            Watch.new(path, &method(:trigger)).run
          end
        end

        def trigger(paths)
          refresh unless Watcher.suspended?
        end

        def targets
          self.class.watch.map do |path|
            path[0, 1] == '~' ? path : "#{self.path}/#{path}"
          end
        end
    end
  end
end
