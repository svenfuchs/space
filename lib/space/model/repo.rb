module Space
  module Model
    class Repo
      autoload :Bundle,     'space/model/repo/bundle'
      autoload :Dependency, 'space/model/repo/dependency'
      autoload :Git,        'space/model/repo/git'

      attr_reader   :project, :path, :git, :bundle

      def initialize(project, path)
        @project = project
        @path    = File.expand_path(path)
        @git     = Git.new(self)
        @bundle  = Bundle.new(self, project.repos)
      end

      def name
        @name ||= File.basename(path)
      end

      def number
        @number ||= project.number(name)
      end

      def ref
        git.commit
      end

      def deps
        bundle.deps
      end

      def refresh
        [git, bundle].each(&:refresh)
      end
    end
  end
end
