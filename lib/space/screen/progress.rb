module Space
  class Screen
    class Progress < View
      def render
        App.logger.debug('RENDER dashboard')
        clear
        render_header
      end

      def notify(event)
        print '.'
      end
    end
  end
end
