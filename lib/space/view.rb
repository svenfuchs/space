require 'erb'

module Space
  class View
    include Helpers

    def template_name
      self.class.name.downcase.split('::').last
    end

    def render(name, assigns)
      assigns.each { |name, value| assign(name, value) }
      template(name).result(binding)
    end

    def assign(key, value)
      instance_variable_set(:"@#{key}", value)
      (class << self; self; end).send(:attr_reader, key)
    end

    def template(name)
      ERB.new(File.read(TEMPLATES[name.to_sym]), nil, '%<>-')
    end
  end
end
