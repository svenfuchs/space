module Space
  class Action
    class Local < Action
      def run
        scope.each do |repo|
          system "bundle config --global local.#{repo.name} #{repo.path}"
        end
        confirm
      end
    end

    class Remote < Action
      def run
        scope.each do |repo|
          system "bundle config --delete local.#{repo.name}"
        end
        confirm
      end
    end

    # class Install < Action
    #   def run
    #     in_scope do |repo|
    #       repo.execute 'bundle install'
    #       repo.refresh
    #     end
    #   end
    # end

    # class Update < Action
    #   def run
    #     in_scope do |repo|
    #       repo.execute 'bundle update'
    #       repo.execute 'git commit -am "bump dependencies"'
    #       repo.refresh
    #     end
    #   end
    # end

    # class Checkout < Action
    #   def run
    #     # check if branch exists, git co (-b)
    #   end
    # end

    # class PullDeps < Action
    #   def run
    #     # pull all dependencies
    #   end
    # end
  end
end
