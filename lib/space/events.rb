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
      App.logger.debug "Event received: #{event.source.class.name} #{event.type}"
      event = args.first.is_a?(Event) ? args.first : Event.new(self, *args)
      buffering? ? buffer.push(event) : observers.each { |observer| observer.notify(event) }
    end
  end
end
