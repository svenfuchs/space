module Space
  class Repo
    attr_reader :app, :number, :path, :git, :bundle

    def initialize(app, number, path)
      @app = app
      @number = number
      @path = File.expand_path(path)
      @git = Git.new(path)
      @bundle = Bundle.new(app, path)
    end

    def name
      @name ||= File.basename(path)
    end

    def ref
      git.commit
    end

    def current?
      app.scope == self
    end

    def dependent_repos
      bundle.deps.map { |dep| app.repos.all.detect { |repo| repo.name == dep.name } }
    end

    def reset
      git.reset
      bundle.reset
    end

    def execute(cmd)
      chdir { system(cmd) }
    end

    def chdir(&block)
      Dir.chdir(path, &block)
    end
  end
end
