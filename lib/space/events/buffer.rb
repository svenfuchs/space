module Space
  module Events
    class Buffer < Array
      def push(event)
        # if any? { |e| e.source == event.source }
        #   App.logger.debug("REJECT event #{event.event.inspect} on #{event.source.class.name.split("\\n").last}")
        # else
          super
        # end
      end

      def flush
        each { |event| event.source.notify(*event) }
        clear
      end
    end
  end
end
