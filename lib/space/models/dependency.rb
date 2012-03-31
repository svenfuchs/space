module Space
  class Dependency
    attr_reader :repos, :name, :ref

    def initialize(repos, name, ref)
      @repos = repos
      @name = name
      @ref = ref
    end

    def fresh?
      repo.ref == ref
    end

    def repo
      repos.find_by_name(name) || raise("cannot find repo #{name}")
    end
  end
end
