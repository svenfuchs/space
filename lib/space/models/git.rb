module Space
  class Git
    include Commands

    COMMANDS = {
      :status => 'git status -s',
      :branch => 'git branch --no-color',
      :commit => 'git log -1 head'
    }

    def clean?
      result(:status).empty?
    end

    def branch
      result(:branch) =~ /^\* (.+)/ && $1.strip
    end

    def commit
      result(:commit) =~ /^commit (\S{7})/ && $1
    end
  end
end
