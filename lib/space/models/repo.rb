module Space
  class Repo
    attr_reader :repos, :number, :path, :git, :bundle

    def initialize(name, repos, number, path)
      @repos  = repos
      @number = number
      @path   = File.expand_path(path)
      @git    = Git.new(path)
      @bundle = Bundle.new(name, repos, path)
    end

    def name
      @name ||= File.basename(path)
    end

    def ref
      git.commit
    end

    def dependencies
      repos.select_by_names(bundle.deps.map(&:name))
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
  end
end
