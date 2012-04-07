module Space
  class App
    class Command
      autoload :Execute, 'space/app/command/builtin'
      autoload :Refresh, 'space/app/command/builtin'
      autoload :Scope,   'space/app/command/builtin'
      autoload :Unscope, 'space/app/command/builtin'

      autoload :Local,   'space/app/command/development'
      autoload :Remote,  'space/app/command/development'

      attr_reader :project, :scope, :args

      def initialize(project, scope, *args)
        @project = project
        @scope   = scope
        @args    = args
      end

      def run
        raise 'not implemented'
      end

      private

        def repos
          @repos ||= project.repos.select_by_names(scope)
        end

        def in_scope
          repos.each { |repo| yield repo }
        end

        def system(cmd)
          puts cmd
          super
        end

        def confirm
          puts "\n--- hit any key to continue ---\n"
          STDIN.getc
        end
    end
  end
end
