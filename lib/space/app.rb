require 'readline'

module Space
  class App
    include Readline

    attr_reader :name, :config, :project, :repos, :screen

    def initialize(name)
      @name    = name
      @config  = Config.load(name)
      @repos   = Repos.new(name, config.paths)
      @project = Project.new(repos)
      @screen  = Screen.new(name, project, repos)

      project.add_observer(self)
      repos.add_observer(self)
    end

    def run
      screen.render
      loop do
        line = readline(prompt, true)
        break if line.nil?
        handle(line) unless line.empty?
      end
    end

    def update
      screen.render(prompt: prompt)
    end

    private

      def handle(line)
        Action.run(self, line)
        screen.render # (prompt: prompt)
      end

      def prompt
        "#{repos.scoped? ? repos.scope.map { |r| r.name }.join(', ') : name} > "
      end
  end
end
