module Space
  module Models
    class Repos
      autoload :Collection, 'space/models/repos/collection'

      attr_accessor :project, :paths, :scope

      def initialize(project, paths)
        @project = project
        @paths = paths
      end

      def all
        @all ||= Collection.new(self, paths.map { |path| Repo.new(project, path) })
      end

      def names
        @names ||= all.map(&:name)
      end

      def scope
        @scope || all
      end

      def scoped?
        !!@scope
      end

      def find_by_name(name)
        all.detect { |repo| repo.name == name } || raise("cannot find repo #{name.inspect}")
      end

      def select_by_names(names)
        Collection.new(self, all.select { |repo| names.include?(repo.name) })
      end

      def subscribe(*args)
        all.each { |repo| repo.subscribe(*args) }
      end
    end
  end
end
