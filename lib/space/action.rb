module Space
  class Action
    autoload :Parser, 'space/action/parser'

    class << self
      def run(app, line)
        new(app, *Parser.new(app.repos.names).parse(line)).run
      end
    end

    attr_reader :app, :repos, :command, :args

    def initialize(app, repos, command, *args)
      @app = app
      @repos = Repos.select(repos) if repos
      @command = normalize(command)
      @args = args
    end

    def run
      if respond_to?(command)
        send(command)
      elsif command
        execute(command)
      end
    end

    def reload
      app.bundle.reset
      run_scoped(true) do |repo|
        repo.reset
      end
    end

    def scope
      app.repos = repos
    end

    def unscope
      app.repos = nil
    end

    def local
      run_scoped do |repo|
        system "bundle config --global local.#{repo.name} #{repo.path}"
      end
    end

    def remote
      run_scoped do |repo|
        system "bundle config --delete local.#{repo.name}"
      end
    end

    def execute(cmd)
      run_scoped do |repo|
        puts
        repo.execute(cmd)
      end
    end

    def run_scoped(reloading = false)
      (repos || app.repos).each { |repo| yield repo }
      confirm && reload unless reloading
    end

    def system(cmd)
      puts cmd
      super
    end

    def confirm
      puts "\n--- hit any key to continue ---\n"
      STDIN.getc
    end

    def normalize(command)
      command = (command || '').strip
      command = 'unscope' if command == '-'
      command = 'scope'   if command.empty?
      command
    end
  end
end
