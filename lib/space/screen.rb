module Space
  class Screen
    attr_reader :name, :repos, :bundle

    def initialize(name, repos, bundle)
      @name = name
      @repos = repos
      @bundle = bundle
    end

    def render
      system 'clear'
      puts render_project
      repos.scope.self_and_dependencies.each do |repo|
        puts render_repo(repo)
      end
    end

    private

      def render_project
         View.new.render(:project, name: name, bundle: bundle)
      end

      def render_repo(repo)
        View.new.render(:repo, repos: repos, repo: repo, git: repo.git, bundle: repo.bundle)
      end
  end
end
