module Space
  module Events
    class Buffer < Array
      def push(event)
        super unless any? { |e| e.source == event.source }
      end

      def flush
        each { |event| event.source.notify(*event) }
        clear
      end
    end
  end
end
