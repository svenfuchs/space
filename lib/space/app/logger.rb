require 'logger'
require 'fileutils'

module Space
  class App
    class Logger < ::Logger
      def initialize
        truncate
        super('/tmp/space.log')
      end

      def truncate
        File.open(filename, 'w+') { |f| f.write('-' * 80 + "\n") }
      end

      def filename
        '/tmp/space.log'
      end
    end
  end
end
