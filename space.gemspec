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

  s.files         = Dir.glob("{lib/**/*,[A-Z]*}")
  s.executables   = 'space'
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
end
