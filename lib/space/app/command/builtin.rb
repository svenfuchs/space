module Space
  class App
    class Command
      class Execute < Command
        def run
          Bundler.with_clean_env do
            Shell::Watcher.ignore do
              in_scope do |repo|
                puts
                repo.execute(*args)
              end
              confirm
            end
          end
        end
      end

      class Refresh < Command
        def run
          Bundler.with_clean_env do
            Shell::Watcher.ignore do
              project.bundler.refresh
              in_scope do |repo|
                repo.refresh
              end
            end
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

