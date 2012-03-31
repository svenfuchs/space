require 'readline'

module Space
  class App
    class << self
      attr_reader :instance

      def run(name)
        @instance = new(name)
        instance.run
      end

      def name
        instance.name
      end

      def config
        instance.config
      end
    end

    include Readline

    attr_reader :name, :config, :repos, :bundle, :screen

    def initialize(name)
      @name   = name
      @config = Config.load(name)
      @repos  = Repos.new(name, config.paths)
      @bundle = Bundle.new(name, repos, config.paths.first)
      @screen  = Screen.new(name, repos, bundle)
    end

    def prompt
      # "#{repos.name} >".strip + ' '
      '> '
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

    # def reset
    #   bundle.reset
    #   repos.each(&:reset)
    # end

    # def execute(cmd)
    #   chdir { system(cmd) }
    # end

    # def chdir(&block)
    #   Dir.chdir(path, &block)
    # end
  end
end

