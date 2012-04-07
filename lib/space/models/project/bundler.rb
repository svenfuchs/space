require 'core_ext/enumerable/map_slice'

module Space
  module Models
    class Project
      class Bundler
        include Events, Shell

        commands config: 'bundle config'

        watch '~/.bundle/config'

        attr_reader :project

        def initialize(project)
          @project = project
          super()
        end

        def config
          lines  = result(:config).split("\n")[2..-1] || []
          values = lines.map_slice(3) do |name, value, _|
            [name, value =~ /: "(.*)"/ && $1]
          end
          Hash[*values.compact.flatten]
        end

        def notify(*args)
          super
        end
      end
    end
  end
end
