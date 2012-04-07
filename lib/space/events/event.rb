module Space
  module Events
    class Event
      attr_reader :source, :event, :data

      def initialize(source, event, data = {})
        @source = source
        @event  = event
        @data   = data
      end
    end
  end
end

