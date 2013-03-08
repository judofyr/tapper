# -*- encoding: utf-8 -*-
$:.push('lib')
require "tapper/version"

Gem::Specification.new do |s|
  s.name     = "tapper"
  s.version  = Tapper::VERSION.dup
  s.date     = "2013-03-08"
  s.summary  = "Write simple TAP tests"
  s.email    = "judofyr@gmail.com"
  s.homepage = "https://github.com/judofyr/tapper"
  s.authors  = ['Magnus Holm']
  
  s.files         = Dir['**/*']
  s.test_files    = Dir['test/**/*'] + Dir['spec/**/*']
  s.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency 'minitest'
  
  ## Make sure you can build the gem on older versions of RubyGems too:
  s.rubygems_version = "2.0.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.specification_version = 3 if s.respond_to? :specification_version
end

