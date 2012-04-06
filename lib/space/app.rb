require 'readline'

module Space
  class App
    autoload :Command, 'space/app/command'
    autoload :Handler, 'space/app/handler'
    autoload :Parser,  'space/app/parser'

    include Readline

    attr_reader :name, :project, :screen

    def initialize(name)
      @name    = name
      @project = Models::Project.new(name)
      @screen  = Screen.new(project)

      project.subscribe(screen)
    end

    def run
      refresh
      screen.display(:dashboard)
      prompt
    end

    private

      def refresh
        screen.display(:progress)
        Shell::Watcher.ignore do
          project.refresh
        end
      end

      def prompt
        loop do
          line = readline(screen.prompt, true)
          break if line.nil?
          handle(line) unless line.empty?
        end
      end

      def handle(line)
        screen.display(:progress)
        Handler.new(project).run(line)
        screen.display(:dashboard)
      end
  end
end

