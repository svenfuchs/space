module Space
  class App
    class Command
      class Execute < Command
        def run
          Bundler.with_clean_env do
            in_scope do |repo|
              repo.buffering do
                puts
                repo.execute(*args)
              end
            end
            confirm
          end
        end
      end

      class Refresh < Command
        def run
          Bundler.with_clean_env do
            project.bundler.refresh
            in_scope do |repo|
              repo.refresh
            end
            project.notify(:update)
          end
        end
      end

      class Scope < Command
        def run
          project.repos.scope = repos
        end
      end

      class Unscope < Command
        def run
          project.repos.scope = nil
        end
      end
    end
  end
end

