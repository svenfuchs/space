module Space
  class Repos < Array
    class << self
      def all
        @all ||= create(App.config.paths)
      end

      def names
        @names ||= all.map(&:name)
      end

      def select(names)
        new(all.select { |repo| names.include?(repo.name) })
      end

      def find_by_name(name)
        all.find_by_name(name)
      end

      def create(paths)
        new(paths.map_with_index { |path, ix| Repo.new(ix + 1, path) })
      end
    end

    def names
      map(&:name)
    end

    def scoped?
      size != self.class.all.size
    end

    # def name
    #   "#{App.name}-(#{names.join('|').gsub("#{App.config.name}-", '')})"
    # end

    def find_by_name(name)
      detect { |repo| repo.name == name }
    end

    def self_and_dependencies
      self.class.new(map { |repo| [repo] + repo.dependencies }.flatten.uniq)
    end
  end
end
