module Space
  class Action
    module Development
      def local
        run_scoped do |repo|
          system "bundle config --global local.#{repo.name} #{repo.path}"
        end
        app.project.reset
      end

      def remote
        run_scoped do |repo|
          system "bundle config --delete local.#{repo.name}"
        end
        project.reset
      end

      def install
        # bundle install
        # refresh
      end

      def update
        # bundle update all outdated deps
        # git commit if successful
        # refresh
      end

      def checkout
        # check if branch exists, git co (-b)
        # check Gemfiles, replace gem "travis-*", :branch => '...' with the new branch
      end

      def pull_deps
        # pull all dependencies
      end
    end
  end
end

