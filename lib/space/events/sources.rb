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

      private

        def register(source)
          Thread.exclusive do
            events.notify(:start) if sources.empty?
            sources << source
          end
        end

        def unregister(source)
          Thread.exclusive do
            sources.delete(source)
            events.notify(:finish) if sources.empty?
          end
        end
    end
  end
end

