require 'rb-fsevent'

module Space
  module Watcher
    def self.included(base)
      base.class_eval do
        class << self
          attr_reader :paths

          def watch(&block)
            @paths = block
          end
        end
      end
    end

    def initialize(*)
      super
      watch!
    end

    def watch_files(paths)
      paths.each do |path|
        event = FSEvent.new
        event.watch(path, file: File.file?(path)) do |paths|
          puts "Detected change inside: #{paths.inspect}"
        end
        event.run
      end
    end

    def paths
      instance_eval(&self.class.paths)
    end
  end
end
