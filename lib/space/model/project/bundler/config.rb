module Space
  module Model
    class Project
      class Bundler
        class Config
          attr_reader :config

          def initialize(config)
            @config = config
          end

          def lines
            config.split("\n")[2..-1] || []
          end

          def data
            lines.map_slice(3) do |name, value, _|
              [name, value =~ /: "(.*)"/ && $1]
            end.compact.flatten
          end

          def to_hash
            Hash[*data]
          end
        end
      end
    end
  end
end

