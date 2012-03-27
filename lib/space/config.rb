module Space
  class Config < Hashr
    class << self
      def load(name)
        paths = %W(~/.space/#{name}.yml ./.#{name}.yml).map { |path| File.expand_path(path) }
        unless path = paths.detect { |path| File.exists?(path) }
          puts("Could not find #{name}.yml at either of ~/.space/#{name}.yml and ./.#{name}.yml")
          exit
        end
        new(YAML.load(File.read(path)))
      end
    end

    def paths
      @paths ||= repositories.map { |path| base_dir ? "#{base_dir}/#{path}" : path }
    end
  end
end
