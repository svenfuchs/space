require 'readline'

module Space
  class App
    include Readline

    attr_reader :name, :config, :project, :screen

    def initialize(name)
      @name    = name
      @config  = Config.load(name)
      @project = Project.new(name, config)
      @screen  = Screen.new(name, config, project, project.repos)

      project.add_observer(self)
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
          screen.clear
          print 'gathering data '
          Commands.preload
          screen.render(options)
        end
      end

      def handle(line)
        Action.run(project, line)
        render
      end

      def prompt
        "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : name} > "
      end
  end
end
