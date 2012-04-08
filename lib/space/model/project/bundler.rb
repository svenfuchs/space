require 'core_ext/enumerable/map_slice'

module Space
  module Model
    class Project
      class Bundler
        autoload :Config, 'space/model/project/bundler/config'

        include Source

        commands config: 'bundle config'

        watch '~/.bundle/config'

        attr_reader :project

        def initialize(project)
          @project = project
          super('.')
        end

        def config
          Config.new(result(:config)).to_hash
        end
      end
    end
  end
end

