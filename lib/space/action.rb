module Space
  class Action
    autoload :Handler, 'space/action/handler'
    autoload :Parser,  'space/action/parser'

    autoload :Execute, 'space/action/builtin'
    autoload :Refresh, 'space/action/builtin'
    autoload :Scope,   'space/action/builtin'
    autoload :Unscope, 'space/action/builtin'

    autoload :Local,   'space/action/development'
    autoload :Remote,  'space/action/development'

    attr_reader :project, :scope, :args

    def initialize(project, scope, *args)
      @project = project
      @scope   = scope
      @args    = args
      log "ACTION #{self.class.name.demodulize} (#{scope.map(&:name).inspect})"
    end

    def run
      raise 'not implemented'
    end

    private

      def in_scope
        scope.each { |repo| yield repo }
      end

      def in_repo(repo, &block)
        puts "in #{repo.path}".ansi(:bold, :green)
        Dir.chdir(repo.path, &block)
      end

      def system(cmd)
        puts "#{cmd.ansi(:bold, :black)}\n"
        super
      end

      def confirm
        puts "--- hit any key to continue ---\n"
        STDIN.getc
      end
  end
end
