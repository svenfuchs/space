module Space
  module Events
    autoload :Buffer, 'space/events/buffer'
    autoload :Event,  'space/events/event'

    attr_reader :buffer

    def buffering
      @buffer = Buffer.new
      yield.tap do
        buffer, @buffer = @buffer, nil
        buffer.flush
      end
    end

    def buffering?
      !!@buffer
    end

    def observers
      @observers ||= []
    end

    def subscribe(observer)
      observers << observer
    end

    def notify(*args)
      event = args.first.is_a?(Event) ? args.first : Event.new(self, *args)
      App.logger.debug "Event on #{self.class.name.split('::').last}: #{event.source.class.name.split('::').last} #{event.event.inspect}"
      buffering? ? buffer.push(event) : observers.each { |observer| observer.notify(event) }
    end
  end
end
