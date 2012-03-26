module Space
  class Repo
    attr_reader :app, :num, :path, :git, :bundle

    def initialize(app, num, path)
      @app = app
      @num = num
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

    def reset
      git.reset
      bundle.reset
    end
  end
end
