require 'observer'

module Space
  class Bundler
    include Watcher, Observable, Commands

    COMMANDS = {
      check:  'bundle check',
      list:   ->(command) { "bundle list | grep #{command.name}" }
    }

    WATCH = [
      'Gemfile',
      'Gemfile.lock'
    ]

    attr_reader :project, :repos

    def initialize(project, repos, path)
      @project = project
      @repos = repos
      super(path)
    end

    def name
      project.name
    end

    def clean?
      info =~ /dependencies are satisfied/
    end

    def info
      result(:check).split("\n").first
    end

    def deps
      result(:list).split("\n").map do |dep|
        if matches = dep.strip.match(/^\* (?<name>[\S]+) \(\d+\.\d+\.\d+(?: (?<ref>.+))?\)/)
          Dependency.new(repos, matches[:name], matches[:ref])
        end
      end.compact
    end
  end
end
