require 'readline'

module Space
  class App
    class Config < Hashr
      def paths
        @paths ||= repositories.map { |path| "#{base_dir}/#{path}" }
      end
    end

    include Readline

    attr_accessor :screen, :name, :config, :repos, :bundle, :scope

    def initialize
      @screen = Screen.new(self)
      @config = Config.new(YAML.load(File.read('space.yml')))
      @name   = config.name
      @repos  = Repos.new(self)
      @bundle = Bundle.new(self, config.paths.first)
    end

    def prompt
      "#{scope ? scope.name : ''} >".strip + ' '
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
  end
end
