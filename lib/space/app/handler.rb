module Space
  class App
    class Handler
      ALIASES = {
        ''  => 'scope',
        '-' => 'unscope',
        'r' => 'refresh'
      }
      attr_reader :project

      def initialize(project)
        @project = project
      end

      def run(line)
        scope, type = parse(line)
        command = command_for(scope, type)
        command.run
      end

      private

        def command_for(scope, type)
          const = const_for(type)
          args  = [project, scope]
          args << type if const == Command::Execute
          const.new(*args)
        end

        def parse(line)
          Parser.new(project.names).parse(line)
        end

        def const_for(type)
          Command.const_get(const_name(type))
        rescue NameError
          Command::Execute
        end

        def const_name(type)
          type = (type || '').strip
          type = ALIASES[type] if ALIASES.key?(type)
          type.capitalize
        end
    end
  end
end
