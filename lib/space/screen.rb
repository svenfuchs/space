module Space
  class Screen
    attr_reader :name, :project, :repos

    def initialize(name, project, repos)
      @name    = name
      @project = project
      @repos   = repos
    end

    def render(options = {})
      puts render_project
      repos.scope.self_and_dependencies.each do |repo|
        puts render_repo(repo)
      end
      print options[:prompt].to_s
    end

    private

      def render_project
         View.new.render(:project, name: name, project: project)
      end

      def render_repo(repo)
        View.new.render(:repo, repos: repos, repo: repo, git: repo.git, bundler: repo.bundler)
      end
  end
end
