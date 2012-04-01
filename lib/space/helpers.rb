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
      format_list(project.local_repos, :width => terminal_width - 2, :prefix => 'Local: ') + "\n" unless project.local_repos.empty?
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

    def format_list(list, options = {})
      width = options[:width] || terminal_width
      result = "#{options[:prefix]}#{list.join(', ')}"
      if result.size <= width
        result
      else
        result = wrap_list(list, width).map { |line| i(line) }
        result.unshift(options[:prefix])
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

    def i(string, width = 2)
      lines = string.split("\n")
      lines = lines.map { |line| line.wrap(80).split("\n") }.flatten
      lines = lines.map { |line| [' ' * width, line].join }
      lines.join("\n")
    end
  end
end
