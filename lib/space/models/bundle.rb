module Space
  class Bundle
    include Commands

    COMMANDS = {
      :check  => 'bundle check',
      :list   => 'bundle list',
      :config => 'bundle config'
    }

    attr_reader :app

    def initialize(app, path)
      @app = app
      super(path)
    end

    def clean?
      info =~ /dependencies are satisfied/
    end

    def info
      result(:check).split("\n").first
    end

    def deps
      @deps ||= result(:list).split("\n").map do |dep|
        names = app.repos.map { |repo| repo.name }
        dep =~ /(#{app.name}.*) \(\d\.\d\.\d (.+)\)/
        Dependency.new(app, $1, $2) if names.include?($1)
      end.compact
    end

    def local_repos
      @local_repos ||= config.keys.map do |key|
        key =~ /^local\.(.+)$/ && $1
      end.compact
    end

    def config
      @config ||= begin
        lines  = result(:config).split("\n")[2..-1]
        values = lines.map_slice(3) do |name, value, _|
          [name, value =~ /: "(.*)"/ && $1]
        end
        Hash[*values.compact.flatten]
      end
    end
  end
end
