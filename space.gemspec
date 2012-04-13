# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'space/version'

Gem::Specification.new do |s|
  s.name          = "space"
  s.version       = Space::VERSION
  s.authors       = ["Sven Fuchs"]
  s.email         = ["me@svenfuchs.com"]
  s.homepage      = "https://github.com/svenfuchs/space"
  s.summary       = "space"
  s.description   = "space."

  s.add_dependency 'ansi', '~> 1.4.2'
  s.add_dependency 'hashr', '~> 0.0.20'
  s.add_dependency 'rb-fsevent'

  s.files         = Dir.glob("{lib/**/*,[A-Z]*}")
  s.platform      = Gem::Platform::RUBY
  s.executables   = ['space']
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
end
