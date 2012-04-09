module Space
  class View
    class Progress < View
      def initialize(*)
        Events.subscribe(self, :start, :update)
        super
        render
      end

      private

        def render
          clear
          render_header
        end

        def on_start
          render
        end

        def on_update
          print '.'
        end
    end
  end
end
