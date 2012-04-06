module Space
  module Models
    class Repos
      class Collection < Array
        attr_reader :repos

        def initialize(repos, elements)
          @repos = repos
          super(elements)
        end

        def names
          map(&:name)
        end

        def self_and_deps
          Collection.new(repos, (self + deps).uniq)
        end

        def deps
          map(&:deps).flatten.map(&:repo).compact
        end
      end
    end
  end
end
