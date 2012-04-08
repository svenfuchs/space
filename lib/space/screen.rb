module Space
  class Screen
    autoload :Progress,  'space/screen/progress'
    autoload :Dashboard, 'space/screen/dashboard'
    autoload :View,      'space/screen/view'

    attr_reader :project, :view

    def initialize(project)
      @project = project
      render_header
    end

    def display
      @views = [Progress.new(project), Dashboard.new(project)]
    end

    # def render
    #   view.render
    #   move prompt.size + 1, 3
    # end

    # def notify(event)
    #   view.notify(event)
    # end

    private

      def render_header
        print "\e[2J" # clear entire screen
        move 0, 0
        puts "Project #{project.name}\n\n"
        puts prompt
      end

      def move(x, y)
        print "\e[#{y};#{x}H"
      end

      def prompt
        "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : project.name} > "
      end

      # def create(screen)
      #   self.class.const_get(screen.to_s.capitalize).new(project)
      # end
  end
end

