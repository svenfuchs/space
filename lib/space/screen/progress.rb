module Space
  class Screen
    class Progress < View
      def render
        clear
        render_header
      end

      def notify(event, data)
        print '.'
      end
    end
  end
end
