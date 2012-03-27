module Space
  class Dependency
    attr_reader :name, :ref

    def initialize(name, ref)
      @name = name
      @ref = ref
    end

    def fresh?
      repo.ref == ref
    end

    def repo
      Repos.find_by_name(name)
    end
  end
end
