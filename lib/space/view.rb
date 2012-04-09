require 'erb'

module Space
  class View
    autoload :Helpers,   'space/view/helpers'
    autoload :Progress,  'space/view/progress'
    autoload :Dashboard, 'space/view/dashboard'

    include Helpers

    attr_reader :project

    def initialize(project)
      @project = project
    end

    def notify(event)
      send(:"on_#{event}")
    end

    private

      def render_header
        print "Project #{project.name}\n\n", :at => [0, 0]
        render_prompt
        move 0, 5
      end

      def render_prompt
        print prompt, :at => [0, 3]
        print "\e[0K", :at => [prompt.size + 1, 3]
      end

      def render_template(name, assigns)
        path = "#{project.config.template_dir}/#{name}.erb"
        print Template.new(path).render(assigns)
      end

      def clear
        print "\e[2J" # clear entire screen
      end

      def print(string, options = {})
        move(*options[:at]) if options.key?(:at)
        super(string)
      end

      def move(x, y)
        print "\e[#{y};#{x}H"
      end

      def prompt
        "#{project.repos.scoped? ? project.repos.scope.map(&:name).join(', ') : project.name} > "
      end
  end
end

