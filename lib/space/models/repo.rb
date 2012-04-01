module Space
  class Repo
    attr_reader :project, :path, :git, :bundle

    def initialize(project, path)
      @project = project
      @path    = File.expand_path(path)
      @git     = Git.new(path)
      @bundle  = Bundle.new(project, path)
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

    def dependencies
      project.repos.select_by_names(bundle.deps.map(&:name))
    end

    def reset
      git.reset
      bundle.reset
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

    def add_observer(observer)
      git.add_observer(observer)
      bundle.add_observer(observer)
    end
  end
end
