module Space
  class Screen
    class Dashboard < View
      def initialize(*)
        Events.subscribe(self, :finish)
        super
      end

      def notify(event)
        render
      end

      private

        def render
          App.log 'RENDER dashboard'
          clear
          render_repos
          move prompt.size + 1, 3
          print "\e[0K"
        end

        def clear
          move 0, 4
          print "\e[J" # clear from cursor down
          move 0, 5
        end

        def prompt
          "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : project.name} > "
        end

        def render_repos
          project.repos.scope.self_and_deps.each do |repo|
            render_template(:repo, assigns(repo))
          end
        end

        def assigns(repo)
          { repos: project.repos, repo: repo, git: repo.git, bundle: repo.bundle }
        end
    end
  end
end
