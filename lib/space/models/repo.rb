module Space
  module Models
    class Repo
      autoload :Bundle,     'space/models/repo/bundle'
      autoload :Dependency, 'space/models/repo/dependency'
      autoload :Git,        'space/models/repo/git'

      attr_reader :project, :path, :git, :bundle

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
        git.refresh
        bundle.refresh
      end

      def execute(cmd)
        chdir do
          puts "in #{path}".ansi(:bold, :yellow)
          system(cmd)
        end
      end

      def chdir(&block)
        Dir.chdir(path, &block)
      end

      def notify(event, data)
        project.notify(event, data)
      end
    end
  end
end
