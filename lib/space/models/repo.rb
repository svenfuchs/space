module Space
  class Repo
    attr_reader :number, :path, :git, :bundle

    def initialize(number, path)
      @number = number
      @path = File.expand_path(path)
      @git = Git.new(path)
      @bundle = Bundle.new(path)
    end

    def name
      @name ||= File.basename(path)
    end

    def ref
      git.commit
    end

    def dependencies
      Repos.select(bundle.deps.map(&:name))
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
