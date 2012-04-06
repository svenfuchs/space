module Space
  module Models
    class Repo
      class Dependency
        attr_reader :repo, :ref

        def initialize(repo, ref)
          @repo = repo
          @ref = ref
        end

        def name
          repo.name
        end

        def fresh?
          repo.ref == ref
        end
      end
    end
  end
end
