module Space
  class Action
    module Builtin
      def refresh
        app.project.reset
        run_scoped(true) do |repo|
          repo.reset
        end
      end

      def scope
        app.repos.scope = repos
      end

      def unscope
        app.repos.scope = nil
      end

      def execute(cmd)
        run_scoped do |repo|
          puts
          repo.execute(cmd)
        end
      end
    end
  end
end
