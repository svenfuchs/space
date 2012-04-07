require 'readline'

module Space
  class App
    autoload :Command, 'space/app/command'
    autoload :Handler, 'space/app/handler'
    autoload :Logger,  'space/app/logger'
    autoload :Parser,  'space/app/parser'

    class << self
      def logger
        @logger ||= Logger.new
      end
    end

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
      cli_loop
    end

    private

      def refresh
        screen.display(:progress)
        project.refresh
      end

      def cli_loop
        loop do
          line = readline(prompt, true)
          break if line.nil?
          handle(line) unless line.empty?
        end
      end

      def handle(line)
        screen.display(:progress)
        Handler.new(project).run(line)
        screen.display(:dashboard)
      end

      def prompt
        "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : project.name} > "
      end
  end
end

