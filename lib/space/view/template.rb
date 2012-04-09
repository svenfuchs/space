module Space
  class View
    class Template
      class << self
        def [](path)
          templates[path] ||= ERB.new(File.read(path), nil, '%<>-')
        end

        def templates
          @templates ||= {}
        end
      end

      include Helpers

      attr_reader :template

      def initialize(path)
        @template = Template[path]
      end

      def render(assigns)
        assigns.each { |key, value| assign(key, value) }
        template.result(binding)
      end

      def assign(key, value)
        instance_variable_set(:"@#{key}", value)
        (class << self; self; end).send(:attr_reader, key)
      end
    end
  end
end
