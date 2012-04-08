module Space
  module Events
    autoload :Subscription, 'space/events/subscription'
    autoload :Sources,      'space/events/sources'

    class << self
      def sources
        @sources ||= Sources.new(self)
      end

      def subscriptions
        @subscriptions ||= []
      end

      def events
        @events ||= []
      end

      def subscribe(observer, *types)
        subscriptions << Subscription.new(observer, types)
      end

      def trigger(event)
        notify(event)
      end

      def flush
        event = events.first
        events.clear
        notify(event, false) if event
      end

      def notify(event)
        subscriptions.each do |subscription|
          subscription.notify(event)
        end
      end
    end

    def trigger(*args)
      Events.trigger(*args)
    end
  end
end
