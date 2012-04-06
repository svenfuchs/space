module Space
  class App
    class Parser
      attr_reader :names, :line

      def initialize(names)
        @names = names
      end

      def parse(line)
        @line = line
        scope = parse_scope
        command = parse_command
        [scope || names, command]
      end

      private

        def parse_scope
          scope = []
          pattern = /^(#{names.join('|')}|\d+)\s*/
          line.gsub!(pattern) { |repo| scope << resolve(repo.strip); '' } while line =~ pattern
          line.strip!
          scope unless scope.empty?
        end

        def parse_command
          line.strip
          line unless line.empty?
        end

        def resolve(repo)
          repo =~ /^\d+$/ ? names[repo.to_i - 1] : repo
        end
    end
  end
end

