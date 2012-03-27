module Space
  class Repos
    include Enumerable

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def [](index)
      scoped[index]
    end

    def each(&block)
      scoped.each(&block)
    end

    def find_by_name(name)
      detect { |repo| repo.name == name }
    end

    def scoped
      app.scope ? ([app.scope] + app.scope.dependent_repos).uniq : all
    end

    def names
      all.map { |repo| repo.name }
    end

    def all
      @all ||= app.config.paths.map_with_index { |path, ix| Repo.new(app, ix + 1, path) }
    end
  end
end
