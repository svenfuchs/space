module Space
  class Config < Hashr
    class << self
      def load(name)
        new(YAML.load(File.read(path(name))))
      end

      private

        def path(name)
          path = paths(name).detect { |path| File.exists?(path) }
          path || raise("Could not find #{name}.yml at either of ~/.space/#{name}.yml and ./.space/#{name}.yml")
        end

        def paths(name)
          %w(. ~).map { |path| File.expand_path("#{path}/.space/#{name}.yml") }
        end
    end

    define :template_dir => File.expand_path('../view/templates', __FILE__)

    def paths
      @paths ||= repositories.map { |path| base_dir ? "#{base_dir}/#{path}" : path }
    end
  end
end
