require 'erb'

module Space
  class View
    include Helpers

    attr_reader :template_dir

    def initialize(template_dir)
      @template_dir = template_dir
    end

    def render(name, assigns)
      assigns.each { |name, value| assign(name, value) }
      template(name).result(binding)
    end

    private

      def assign(key, value)
        instance_variable_set(:"@#{key}", value)
        (class << self; self; end).send(:attr_reader, key)
      end

      def templates
        @templates ||= {}
      end

      def template(name)
        templates[name] ||= ERB.new(File.read("#{template_dir}/#{name}.erb"), nil, '%<>-')
      end
  end
end
