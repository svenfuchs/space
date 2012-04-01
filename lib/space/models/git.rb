require 'observer'

module Space
  class Git
    include Watcher, Observable, Commands

    COMMANDS = {
      status: 'git status',
      branch: 'git branch --no-color',
      commit: 'git log -1 HEAD'
    }

    WATCH = [
      '.'
    ]

    def branch
      result(:branch) =~ /^\* (.+)/ && $1.strip
      # ignore_updates('.git/') do
      #   result(:branch) =~ /^\\* (.+)/ && $1.strip
      # end
    end

    def commit
      result(:commit) =~ /^commit (\S{7})/ && $1
      # ignore_updates('.git/') do
      #   result(:commit) =~ /^commit (\\S{7})/ && $1
      # end
    end

    def status
      dirty? ? :dirty : (ahead? ? :ahead : :clean)
    end

    def ahead?
      ahead > 0
    end

    def ahead
      result(:status) =~ /Your branch is ahead of .* by (\d+) commits?\./ ? $1.to_i : 0
      # ignore_updates('.git/') do
      #   result(:status) =~ /Your branch is ahead of .* by (\\d+) commits?\\./ ? $1.to_i : 0
      # end
    end

    def dirty?
      !clean?
    end

    def clean?
      result(:status).include?('nothing to commit (working directory clean)')
      # ignore_updates('.git') do
      #   result(:status).include?('nothing to commit (working directory clean)')
      # end
    end

    # private

    #   def update(paths)
    #     p paths
    #     super
    #   end
  end
end
