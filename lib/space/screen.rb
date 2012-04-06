module Space
  class Screen
    autoload :Progress,  'space/screen/progress'
    autoload :Dashboard, 'space/screen/dashboard'
    autoload :View,      'space/screen/view'

    attr_reader :project, :current

    def initialize(project)
      @project = project
    end

    def prompt
      "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : project.name} > "
    end

    def display(screen)
      @current = create(screen).tap { |screen| screen.render }
    end

    def notify(event, data)
      current.notify(event, data)
    end

    private

      def create(screen)
        self.class.const_get(screen.to_s.capitalize).new(project)
      end
  end
end
