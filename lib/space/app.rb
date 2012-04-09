require 'space/logger'
require 'readline'
require 'thread'

module Space
  class App
    attr_reader :name, :project, :views

    def initialize(name)
      @name    = name
      @project = Model::Project.new(name)
      @views   = [View::Progress.new(project), View::Dashboard.new(project)]
    end

    def run
      project.refresh
      cli_loop
      puts
    end

    private

      def cli_loop
        loop do
          print "\e[3;0H"
          line = Readline.readline(views.first.send(:prompt), true) || break
          handle(line)
        end
      rescue Exception => e
        log e.message, e.backtrace
      end

      def handle(line)
        Action::Handler.new(project).run(line) unless line.empty?
      end
  end
end
