module Space
  class Config < Hashr
    class << self
      def load(name)
        new(YAML.load(File.read(path(name))))
      end

      def path(name)
        path = paths(name).detect { |path| File.exists?(path) }
        path || abort("Could not find #{name}.yml at either of ~/.space/#{name}.yml and ./.#{name}.yml")
      end

      def paths(name)
        %W(~/.space/#{name}.yml ./.#{name}.yml).map do |path|
          File.expand_path(path)
        end
      end
    end

    define :template_dir => File.expand_path('../templates', __FILE__)

    def paths
      @paths ||= repositories.map { |path| base_dir ? "#{base_dir}/#{path}" : path }
    end
  end
end
