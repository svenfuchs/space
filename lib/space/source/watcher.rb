module Space
  module Source
    module Watcher
      attr_reader :path

      def initialize(path)
        @path = path
        start
      end

      def watched_paths
        @watched_paths ||= self.class.watch.map do |path|
          path[0, 1] == '~' ? path : "#{self.path}/#{path}"
        end
      end

      private

        def start
          watchers.map(&:run)
        end

        def watchers
          @watchers ||= watched_paths.map do |path|
            Watch.new(path) do |paths|
              refresh
            end
          end
        end
    end
  end
end
