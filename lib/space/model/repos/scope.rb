module Space
  module Model
    class Repos
      class Collection < Array
        attr_reader :repos

        def initialize(repos, elements)
          @repos = repos
          super(elements)
        end

        def self_and_dependencies
          Collection.new(repos, (self + map(&:dependencies)).flatten.uniq)
        end
      end
    end
  end
end
