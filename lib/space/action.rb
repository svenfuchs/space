module Space
  class Action
    class << self
      def run(app, line)
        action = new(app, *parse(app.repos.names, line))
        action.run if action
      end

      def parse(names, line)
        [parse_repo(names, line), line.strip]
      end

      def parse_repo(names, line)
        repo = nil
        line.gsub!(/^(#{names.join('|')}|\d+)/) do |name|
          repo = name =~ /^\d+$/ ? names[name.to_i - 1] : name
          ''
        end
        repo
      end
    end

    attr_reader :app, :repo, :command

    def initialize(app, repo, command)
      @app = app
      @repo = app.repos.find_by_name(repo) || app.scope
      @command = normalize(command)
    end

    def run
      if respond_to?(command)
        send(command)
      elsif repo
        execute(command)
      end
    end

    def reload
      repo ? repo.reset : app.repos.each(&:reset)
    end

    def scope
      app.scope = repo
    end

    def unscope
      app.scope = nil
    end

    def execute(command)
      puts
      repo.execute(command)
      puts "\n--- hit any key to continue ---\n"
      STDIN.getc
      reload
    end

    def normalize(command)
      command = command.strip
      command = 'unscope' if command == '-'
      command = 'scope'   if command.empty?
      command
    end
  end
end
