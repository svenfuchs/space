require 'ansi/core'

module Space
  class Action
    class Execute < Action
      def run
        in_scope do |repo|
          in_repo(repo) do
            system(*args)
            puts
          end
        end
        confirm
      end
    end

    class Refresh < Action
      def run
        project.bundler.refresh
        in_scope do |repo|
          repo.refresh
        end
      end
    end

    class Scope < Action
      def run
        project.repos.scope = scope
        Events.notify(:finish)
      end
    end

    class Unscope < Action
      def run
        project.repos.scope = nil
        Events.notify(:finish)
      end
    end
  end
end
