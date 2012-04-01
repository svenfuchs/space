module Space
  class Screen
    attr_reader :name, :project, :repos, :view

    def initialize(name, config, project, repos)
      @name    = name
      @project = project
      @repos   = repos
      @view    = View.new(config.template_dir)
    end

    def clear
      print "\e[2J\e[0;0H" # clear screen, move cursor to home
      puts render_project
    end

    def render(options = {})
      clear
      puts render_config
      repos.scope.self_and_dependencies.each do |repo|
        puts render_repo(repo)
      end
      print options[:prompt].to_s
    end

    private

      def render_project
         view.render(:project, name: name, project: project)
      end

      def render_config
         view.render(:config, project: project)
      end

      def render_repo(repo)
        view.render(:repo, repos: repos, repo: repo, git: repo.git, bundle: repo.bundle)
      end
  end
end
