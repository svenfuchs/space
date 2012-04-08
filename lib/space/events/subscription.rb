module Space
  module Events
    class Subscription
      attr_reader :observer, :types

      def initialize(observer, types)
        @observer = observer
        @types    = types
      end

      def notify(event)
        observer.notify(event) if matches?(event)
      end

      private

        def matches?(event)
          # log [observer.class, types, event].inspect
          types.empty? || types.include?(event)
        end
    end
  end
end
