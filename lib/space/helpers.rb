# encoding: UTF-8
require 'ansi/core'
require 'core_ext/string'

module Space
  module Helpers
    def project_title
      "Project: #{name}".ansi(:bold)
    end

    def repo_title
      title = "#{repo.name.ansi(:bold)} [#{git.branch}, #{git.commit}] [#{repo.number}]"
      title += " *" if repo_selected?
      title
    end

    def repo_selected?
      repos.scoped? && repos.scope.include?(repo)
    end

    def git_status
      "Git: #{format_boolean(git.clean?)}#{git_ahead if git.ahead?}"
    end

    def git_ahead
      " #{git.ahead} commits ahead".ansi(:cyan)
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

    def bundle_local
      repos = bundle.local_repos
      "\nLocal: #{repos.join(', ')}\n" unless repos.empty?
    end

    def format_boolean(value)
      value ? '✔'.ansi(:green, :bold) : '⚡'.ansi(:red, :bold)
    end

    def i(string)
      lines = string.split("\n")
      lines = lines.map { |line| line.wrap(80).split("\n") }.flatten
      lines = lines.map { |line| "  #{line}" }
      lines.join("\n")
    end
  end
end
