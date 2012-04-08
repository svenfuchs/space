module Space
  module Model
    class Repo
      class Git
        include Source

        commands  status: 'git status',
                  branch: 'git branch --no-color',
                  commit: 'git log -1 --no-color HEAD'

        watch '.'

        attr_reader :repo

        def initialize(repo)
          @repo = repo
          super(repo.path)
        end

        def status
          dirty? ? :dirty : (ahead? ? :ahead : :clean)
        end

        def dirty?
          !clean?
        end

        def ahead?
          ahead > 0
        end

        def clean?
          result(:status) =~ /nothing to commit (working directory clean)/
        end

        def ahead
          result(:status) =~ /Your branch is ahead of .* by (\d+) commits?\./ ? $1.to_i : 0
        end

        def branch
          result(:branch) =~ /^\* (.+)/ && $1.strip
        end

        def commit
          result(:commit) =~ /^commit (\S{7})/ && $1
        end
      end
    end
  end
end
