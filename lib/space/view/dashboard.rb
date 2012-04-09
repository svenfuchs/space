module Space
  class View
    class Dashboard < View
      def initialize(*)
        Events.subscribe(self, :finish)
        super
      end

      private

        def on_finish
          App.log 'RENDER dashboard'
          clear
          render_header
          render_repos
          render_prompt
        end

        def render_repos
          project.repos.scope.self_and_deps.each do |repo|
            render_repo(repo)
          end
        end

        def render_repo(repo)
          assigns = { project: project, repos: project.repos, repo: repo, git: repo.git, bundle: repo.bundle }
          render_template(:repo, assigns)
        end
    end
  end
end
