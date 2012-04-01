require 'observer'

module Space
  class Bundler
    include Watcher, Observable, Commands

    COMMANDS = {
      check:  'bundle check',
      list:   'bundle list | grep %<name>s',
    }

    WATCH = [
      'Gemfile',
      'Gemfile.lock'
    ]

    attr_reader :name, :repos

    def initialize(name, repos, path)
      @name = name
      @repos = repos
      super(path)
    end

    def clean?
      info =~ /dependencies are satisfied/
    end

    def info
      result(:check).split("\n").first
    end

    def deps
      result(:list, name: name).split("\n").map do |dep|
        if matches = dep.strip.match(/^\* (?<name>[\S]+) \(\d+\.\d+\.\d+(?: (?<ref>.+))?\)/)
          Dependency.new(repos, matches[:name], matches[:ref])
        end
      end.compact
    end
  end
end
