require 'observer'

module Space
  class Bundle
    include Watcher, Observable, Commands

    COMMANDS = {
      check:  'bundle check',
      list:   ->(command) { "bundle list | grep #{command.name}" }
    }

    WATCH = [
      'Gemfile',
      'Gemfile.lock'
    ]

    attr_reader :project

    def initialize(project, path)
      @project = project
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
          Dependency.new(project.repos, matches[:name], matches[:ref])
        end
      end.compact
    end
  end
end
