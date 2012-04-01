require 'readline'

module Space
  class App
    include Readline

    attr_reader :name, :config, :project, :repos, :screen

    def initialize(name)
      @name    = name
      @config  = Config.load(name)
      @project = Project.new(self, name)
      @repos   = Repos.new(project, config.paths)
      @screen  = Screen.new(name, project, repos)

      project.add_observer(self)
      repos.add_observer(self)
    end

    def run
      render
      loop do
        line = readline(prompt, true)
        break if line.nil?
        handle(line) unless line.empty?
      end
    end

    def update
      render(prompt: prompt)
    end

    private

      def render(options = {})
        Watcher.ignore do
          print "\e[2J\e[0;0H" # clear screen, move cursor to home
          Commands.preload
          screen.render(options)
        end
      end

      def handle(line)
        Action.run(self, line)
        render
      end

      def prompt
        "#{repos.scoped? ? repos.scope.map { |r| r.name }.join(', ') : name} > "
      end
  end
end
