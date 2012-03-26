module Space
  module System
    attr_reader :path

    def initialize(path = '~')
      @path = File.expand_path(path)
    end

    def run(cmd)
      chdir { `#{cmd}` }
    end

    def chdir(&block)
      Dir.chdir(path, &block)
    end

    def strip_ansi(string)
      string.gsub(/\e\[\d+m/, '')
    end
  end
end
