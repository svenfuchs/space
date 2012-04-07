module Space
  module Shell
    module Watcher
      class << self
        def ignore
          @ignore = true
          yield.tap do
            @ignore= false
          end
        end

        def ignore?
          !!@ignore
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

        def ignore_updates(*paths, &block)
          Watcher.ignore_updates(*paths, &block)
        end

        def trigger(paths)
          refresh
        end

        def targets
          self.class.watch.map do |path|
            "#{self.path}/#{path}"
          end
        end
    end
  end
end
