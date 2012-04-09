require 'ansi/core'

module Space
  class Action
    class Execute < Action
      def run
        Events.sources.registered do
          in_scope do |repo|
            Dir.chdir(repo.path) do
              puts "in #{repo.path}\n".ansi(:bold, :green)
              system(*args)
              puts
            end
          end
          confirm
        end
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
