# encoding: UTF-8
require 'ansi/core'
require 'ansi/terminal'
require 'core_ext/string'

module Space
  module Helpers
    include ANSI::Terminal

    def project_title
      "Project: #{name}".ansi(:bold)
    end

    def local_repos
      "\n#{format_list(project.local_repos, :width => terminal_width, :prefix => 'Local: ')}\n" unless project.local_repos.empty?
    end

    def tableize(string)
      string.split(' ')
      project.local_repos.join(', ')
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
      " #{git.ahead} commit#{'s' if git.ahead > 1} ahead".ansi(:yellow)
    end

    def bundler_status
      "Bundle: #{format_boolean(bundler.clean?)}"
    end

    def bundler_info
      bundler.info.ansi(:red) unless bundler.clean?
    end

    def bundler_deps
      bundler.deps.map { |dep| "• #{dep.ref} #{format_boolean(dep.fresh?)} #{dep.name}" }.join("\n")
    end

    def format_boolean(value)
      value ? '✔'.ansi(:green, :bold) : '⚡'.ansi(:red, :bold)
    end

    def format_list(list, options = {})
      width = options[:width] || terminal_width
      result = "#{options[:prefix]}#{list.join(', ')}"
      if result.size <= width
        result
      else
        result = wrap_list(list, width)
        result = result.map { |line| i(line) }
        result[0] = "#{options[:prefix]}#{result[0].strip}"
        result.join("\n")
      end
    end

    def wrap_list(list, width)
      result = ['']
      list.each do |item|
        result << '' if (result.last + item).size + 1 > width
        result.last << "#{item}#{', ' unless list.last == item}"
      end
      result.map(&:strip)
    end

    def i(string)
      lines = string.split("\n")
      lines = lines.map { |line| line.wrap(80).split("\n") }.flatten
      lines = lines.map { |line| "  #{line}" }
      lines.join("\n")
    end
  end
end
