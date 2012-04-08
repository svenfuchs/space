module Space
  class Screen
    class Progress < View
      def initialize(*)
        super
        Events.subscribe(self, :start, :update)
      end

      def notify(event)
        case event
        when :start
          clear
        when :update
          print '.'
        end
      end

      private

        def clear
          move 0, 5
          print "\e[0J" # clear from cursor down
        end
    end
  end
end
