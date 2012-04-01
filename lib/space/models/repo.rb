module Space
  class Repo
    attr_reader :repos, :number, :path, :git, :bundler

    def initialize(name, repos, number, path)
      @repos   = repos
      @number  = number # TODO optionally find the tmux window number from `tmux list-windows`
      @path    = File.expand_path(path)
      @git     = Git.new(path)
      @bundler = Bundler.new(name, repos, path)
    end

    def name
      @name ||= File.basename(path)
    end

    def ref
      git.commit
    end

    def dependencies
      repos.select_by_names(bundler.deps.map(&:name))
    end

    def reset
      git.reset
      bundler.reset
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
      bundler.add_observer(observer)
    end
  end
end
