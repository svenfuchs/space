require 'logger'
require 'fileutils'

module Kernel
  def log(*msgs)
    $logger.log(*msgs)
  end
end

module Space
  class Logger < ::Logger
    def initialize(path)
      truncate
      super
      self.formatter = ->(severity, datetime, progname, msg) { "#{msg}\n" }
    end

    def log(*msgs)
      msgs.each do |msg|
        info msg.is_a?(Array) ? msg.join("\n") : msg
      end
    end

    def truncate
      File.open(filename, 'w+') { |f| f.write('-' * 80 + "\n") }
    end

    def filename
      '/tmp/space.log'
    end
  end
end

$logger = Space::Logger.new('/tmp/space.log')
