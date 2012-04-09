require 'core_ext/string/demodulize'

module Space
  class Action
    class Handler
      ALIASES = {
        ''  => 'scope',
        '-' => 'unscope',
        '!' => 'refresh',
        'r' => 'remote',
        'l' => 'local'
      }
      attr_reader :project

      def initialize(project)
        @project = project
      end

      def run(line)
        scope, type = parse(line)
        action = action_for(scope, type)
        Events.sources.registered do
          action.run
        end
      end

      private

        def action_for(scope, type)
          const = const_for(type)
          repos = repos_for(scope)
          args  = [project, repos]
          args << type if const == Action::Execute
          const.new(*args)
        end

        def parse(line)
          Parser.new(project.repos.names).parse(line)
        end

        def const_for(type)
          Action.const_get(const_name(type))
        rescue NameError
          Action::Execute
        end

        def const_name(type)
          type = (type || '').strip
          type = ALIASES[type] if ALIASES.key?(type)
          type.capitalize
        end

        def repos_for(scope)
          scope ? project.repos.select_by_names_or_numbers(scope) : project.repos.scope.self_and_deps
        end
    end
  end
end
