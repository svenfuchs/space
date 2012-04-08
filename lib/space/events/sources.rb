module Space
  module Events
    class Sources
      attr_reader :events, :sources

      def initialize(events)
        @events  = events
        @sources = []
      end

      def registered
        register(Thread.current.object_id)
        yield.tap do
          unregister(Thread.current.object_id)
        end
      end

      def register(source)
          events.trigger(:start) if sources.empty?
          sources << source
      end

      def unregister(source)
          sources.delete(source)
          events.trigger(:finish) if sources.empty?
      end
    end
  end
end

