module Space
  class Screen
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def render
      system 'clear'
      puts render_project
      repos = app.repos.scoped? ? app.repos.self_and_dependencies : app.repos
      repos.each do |repo|
        puts render_repo(repo)
      end
    end

    private

      def render_project
         View.new.render(:project, :app => app, :bundle => app.bundle)
      end

      def render_repo(repo)
        View.new.render(:repo, :app => app, :repo => repo, :git => repo.git, :bundle => repo.bundle)
      end
  end
end
