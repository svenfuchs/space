module Space
  module Model
    class Repo
      class Bundle
        include Source

        commands check: 'bundle check --no-lock',
                 list:  'bundle list'

        watch 'Gemfile',
              'Gemfile.lock'

        attr_reader :repos

        def initialize(repo, repos)
          @repo = repo
          @repos = repos
          super(repo.path)
        end

        def clean?
          info =~ /dependencies are satisfied/
        end

        def info
          result(:check).split("\n").first || ''
        end

        def deps
          result(:list).scan(/\* ([\w-]+) \(.* ([\d|\w]+)\)/).map do |name, ref|
            Dependency.new(repos.find_by_name(name), ref) if repos.names.include?(name)
          end.compact
        end
      end
    end
  end
end

