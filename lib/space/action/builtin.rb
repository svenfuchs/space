module Space
  class Action
    module Builtin
      def refresh
        project.bundler.reset
        run_scoped(true) do |repo|
          repo.reset
        end
      end

      def scope
        project.repos.scope = repos
      end

      def unscope
        project.repos.scope = nil
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
