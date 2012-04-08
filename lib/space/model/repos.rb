module Space
  module Model
    class Repos
      autoload :Collection, 'space/model/repos/collection'

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

      def scope=(scope)
        log "SCOPE: #{scope ? scope.map(&:name) : '-'}"
        @scope = scope
      end

      def scope
        @scope || all
      end

      def scoped?
        !!@scope
      end

      def find_by_name_or_number(repo)
        repo =~ /^\d+$/ ? find_by_number(repo.to_i) : find_by_name(repo)
      end

      def find_by_name(name)
        all.detect { |repo| repo.name == name } || raise("cannot find repo by name #{name.inspect}")
      end

      def find_by_number(number)
        all.detect { |repo| repo.number == number } || raise("cannot find repo by number #{number.inspect}")
      end

      def select_by_names_or_numbers(repos)
        Collection.new(self, repos.map { |repo| find_by_name_or_number(repo) })
      end

      def select_by_names(names)
        Collection.new(self, all.select { |repo| names.include?(repo.name) })
      end

      def refresh
        all.each(&:refresh)
      end
    end
  end
end
