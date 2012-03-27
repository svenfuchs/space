require 'yaml'
require 'hashr'
require 'core_ext/enumerable'

module Space
  autoload :Action,     'space/action'
  autoload :App,        'space/app'
  autoload :Helpers,    'space/helpers'
  autoload :Bundle,     'space/models/bundle'
  autoload :Commands,   'space/models/commands'
  autoload :Command,    'space/models/command'
  autoload :Dependency, 'space/models/dependency'
  autoload :Git,        'space/models/git'
  autoload :Repos,      'space/models/repos'
  autoload :Repo,       'space/models/repo'
  autoload :Screen,     'space/screen'
  autoload :System,     'space/system'
  autoload :View,       'space/view'

  TEMPLATES = {
    :project => 'lib/space/templates/project.erb',
    :repo    => 'lib/space/templates/repository.erb'
  }
end
