# encoding: UTF-8
require 'ansi/core'
require 'core_ext/string'

module Space
  module Helpers
    def project_title
      "Project: #{name}".ansi(:bold)
    end

    def tableize(string)
      string.split(' ')
      project.local_repos.join(', ')
    end

    def repo_name
      repo.name.ansi(:bold)
    end

    def repo_status
      [git.branch, git.commit, repo_local].compact.join(', ')
    end

    def repo_local
      'L'.ansi(:bold, :red) if repo_local?
    end

    def repo_local?
      project.local_repos.include?(repo.name)
    end

    def repo_selected?
      repos.scoped? && repos.scope.include?(repo)
    end

    def git_status
      "Git: #{format_boolean(git.clean?)}#{git_ahead if git.ahead?}"
    end

    def git_ahead
      " #{git.ahead} commit#{'s' if git.ahead > 1} ahead".ansi(:yellow)
    end

    def bundle_status
      "Bundle: #{format_boolean(bundle.clean?)}"
    end

    def bundle_info
      bundle.info.ansi(:red) unless bundle.clean?
    end

    def bundle_deps
      bundle.deps.map { |dep| "• #{dep.ref} #{format_boolean(dep.fresh?)} #{dep.name}" }.join("\n")
    end

    def format_boolean(value)
      value ? '✔'.ansi(:green, :bold) : '⚡'.ansi(:red, :bold)
    end

    def i(string, width = 2)
      lines = string.split("\n")
      lines = lines.map { |line| line.wrap(80).split("\n") }.flatten
      lines = lines.map { |line| [' ' * width, line].join }
      lines.join("\n")
    end
  end
end
