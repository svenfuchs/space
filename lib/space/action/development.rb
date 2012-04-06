module Space
  class Action
    module Development
      def local
        run_scoped do |repo|
          system "bundle config --global local.#{repo.name} #{repo.path}"
        end
        project.bundler.reset
      end

      def remote
        run_scoped do |repo|
          system "bundle config --delete local.#{repo.name}"
        end
        project.bundler.reset
      end

      def install
        run_scoped do |repo|
          repo.execute 'bundle install'
          repo.reset
        end
      end

      def update
        run_scoped do |repo|
          repo.execute 'bundle update'
          repo.execute 'git commit -am "bump dependencies"'
          repo.reset
        end
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

