require 'yaml'
require 'hashr'
require 'core_ext/enumerable'

module Space
  autoload :Action,     'space/action'
  autoload :App,        'space/app'
  autoload :Config,     'space/config'
  autoload :Helpers,    'space/helpers'
  autoload :Screen,     'space/screen'
  autoload :System,     'space/system'
  autoload :View,       'space/view'
  autoload :Watch,      'space/watch'

  autoload :Bundler,    'space/models/bundler'
  autoload :Commands,   'space/models/commands'
  autoload :Command,    'space/models/command'
  autoload :Dependency, 'space/models/dependency'
  autoload :Git,        'space/models/git'
  autoload :Project,    'space/models/project'
  autoload :Repos,      'space/models/repos'
  autoload :Repo,       'space/models/repo'
  autoload :Watcher,    'space/models/watcher'

  TEMPLATES = {
    project: 'lib/space/templates/project.erb',
    repo:    'lib/space/templates/repository.erb'
  }
end
