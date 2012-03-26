# encoding: UTF-8
require 'ansi/core'
require 'core_ext/string'

module Space
  module Helpers
    def project_title
      "Project: #{app.name}".ansi(:bold)
    end

    def git_status
      "Git: #{format_boolean(git.clean?)}"
    end

    def bundle_status
      "Bundle: #{format_boolean(bundle.clean?)}"
    end

    def bundle_info
      "#{bundle.info}\n" unless bundle.clean?
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
