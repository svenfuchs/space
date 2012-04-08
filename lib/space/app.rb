require 'space/logger'
require 'readline'
require 'thread'

module Space
  class App
    attr_reader :name, :project, :screen

    def initialize(name)
      @name    = name
      @project = Model::Project.new(name)
      @screen  = Screen.new(project)
    end

    def run
      log 'foo'
      screen.display
      project.refresh
      cli_loop
      # Thread.new(&method(:cli_loop))
      # sleep
      puts
    end

    private

      def cli_loop
        loop do
          print "\e[3;0H"
          line = Readline.readline(prompt, true) || break
          handle(line)
        end
      rescue Exception => e
        log e.message, e.backtrace
      end

      def handle(line)
        Action::Handler.new(project).run(line) unless line.empty?
      end

      def prompt
        "#{project.repos.scoped? ? project.repos.scope.map { |r| r.name }.join(', ') : project.name} > "
      end
  end
end
