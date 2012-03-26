module Space
  class Repos
    include Enumerable

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def each(&block)
      all.each(&block)
    end

    def all
      @all ||= app.config.paths.map_with_index { |path, ix| Repo.new(app, ix, path) }
    end
  end
end
