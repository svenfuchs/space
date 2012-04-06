require 'erb'

module Space
  class Screen
    class View
      include Helpers

      attr_reader :project

      def initialize(project)
        @project = project
      end

      private

        # TODO duplicate from screen
        def prompt
          "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : project.name} > "
        end

        def clear
          print "\e[2J\e[0;0H" # clear screen, move cursor to home
        end

        def render_header
          puts "Project #{project.name}\n\n"
        end

        def render_template(name, assigns)
          assigns.each { |name, value| assign(name, value) }
          print template(name).result(binding)
        end

        def assign(key, value)
          instance_variable_set(:"@#{key}", value)
          (class << self; self; end).send(:attr_reader, key)
        end

        def templates
          @templates ||= {}
        end

        def template(name)
          templates[name] ||= ERB.new(File.read("#{project.config.template_dir}/#{name}.erb"), nil, '%<>-')
        end
    end
  end
end
