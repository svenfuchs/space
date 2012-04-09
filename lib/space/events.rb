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

      def notify(event)
        # log event
        subscriptions.each do |subscription|
          subscription.notify(event)
        end
      end
    end

    def notify(*args)
      Events.notify(*args)
    end
  end
end
