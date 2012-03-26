module Space
  class Dependency
    attr_reader :app, :name, :ref

    def initialize(app, name, ref)
      @app = app
      @name = name
      @ref = ref
    end

    def fresh?
      repo.ref == ref
    end

    def repo
      app.repos.detect { |repo| repo.name == name }
    end
  end
end
