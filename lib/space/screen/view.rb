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

        def move(x, y)
          print "\e[#{y};#{x}H"
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
