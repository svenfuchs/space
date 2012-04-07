module Space
  class Screen
    autoload :Progress,  'space/screen/progress'
    autoload :Dashboard, 'space/screen/dashboard'
    autoload :View,      'space/screen/view'

    attr_reader :project, :view

    def initialize(project)
      @project = project
    end

    def display(name)
      @view = create(name)
      render
    end

    def render
      view.render
    end

    def notify(event)
      view.notify(event)
    end

    private

      def create(screen)
        self.class.const_get(screen.to_s.capitalize).new(project)
      end
  end
end
