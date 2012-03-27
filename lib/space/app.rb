require 'readline'

module Space
  class App
    class << self
      attr_reader :config

      def run(name)
        @config = Config.load(name)
        new(config.name || name).run
      end
    end

    include Readline

    attr_accessor :screen, :name, :repos, :bundle, :path

    def initialize(name)
      @screen = Screen.new(self)
      @name   = name
      @bundle = Bundle.new(self.class.config.paths.first)
      @path   = File.expand_path('.')
    end

    def prompt
      # "#{repos.name} >".strip + ' '
      '> '
    end

    def repos
      @repos ||= Repos.all
    end

    def run
      screen.render
      loop do
        line = readline(prompt, true)
        break if line.nil?
        handle(line) unless line.empty?
      end
      puts
    end

    def handle(line)
      Action.run(self, line)
      screen.render
    end

    def reset
      bundle.reset
      repos.each(&:reset)
    end

    def execute(cmd)
      chdir { system(cmd) }
    end

    def chdir(&block)
      Dir.chdir(path, &block)
    end
  end
end

