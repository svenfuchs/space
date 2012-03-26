require 'readline'

module Space
  class App
    class Config < Hashr
      def paths
        @paths ||= repositories.map { |path| "#{base_dir}/#{path}" }
      end
    end

    include Readline

    attr_reader :screen, :name, :config, :repos, :bundle

    def initialize
      @screen = Screen.new(self)
      @config = Config.new(YAML.load(File.read('space.yml')))
      @name   = config.name
      @repos  = Repos.new(self)
      @bundle = Bundle.new(self, config.paths.first)
    end

    def run
      screen.render
      loop do
        line = readline('huzzar > ', true)
        break if line.nil?
        handle(line) unless line.empty?
      end
      puts
    end

    def handle(line)
      action = parse(line)
      # action.run
      screen.render
    end

    def parse(line)
      line =~ /(\S+) (.+)/
      name, command = $1, $2
      repo = repos.detect { |repo| repo.name == name }
      case $2
      when 'reload'
        repo.reset
      end
    end
  end
end
