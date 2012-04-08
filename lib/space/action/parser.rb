module Space
  class Action
    class Parser
      attr_reader :names, :line

      def initialize(names)
        @names = names
      end

      def parse(line)
        @line = line
        scope = parse_scope
        command = parse_command
        [scope, command]
      end

      private

        def parse_scope
          scope = []
          pattern = /^(#{names.join('|')}|\d+)\s*/
          line.gsub!(pattern) { |repo| scope << repo.strip; '' } while line =~ pattern
          line.strip!
          scope unless scope.empty?
        end

        def parse_command
          line.strip
          line unless line.empty?
        end
    end
  end
end


