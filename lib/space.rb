require 'yaml'
require 'hashr'

module Space
  autoload :Action,     'space/action'
  autoload :App,        'space/app'
  autoload :Config,     'space/config'
  autoload :Events,     'space/events'
  autoload :Helpers,    'space/helpers'
  autoload :Logger,     'space/logger'
  autoload :Model,      'space/model'
  autoload :Screen,     'space/screen'
  autoload :Source,     'space/source'
  autoload :Tmux,       'space/tmux'
end
