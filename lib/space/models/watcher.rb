module Space
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
      super
      watch
    end

    private

      def watch
        targets.each do |path|
          Watch.new(path, &method(:update)).run
        end
      end

      def ignore_updates(*paths, &block)
        Watcher.ignore_updates(*paths, &block)
      end

      def update(paths)
        unless Watcher.ignore?
          reset
          changed
          notify_observers
        end
      end

      def targets
        Array(self.class::WATCH).map do |path|
          "#{self.path}/#{path}"
        end
      end
  end
end
