module Space
  class Screen
    class Dashboard < View
      def render(options = {})
        clear
        render_header
        render_repos
        print options[:prompt].to_s
      end

      def notify(event, data)
        p "RENDER DASHBOARD"
        render(prompt: prompt)
      end

      private

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
