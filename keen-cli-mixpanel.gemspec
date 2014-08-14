# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "keen-cli-mixpanel/version"

Gem::Specification.new do |s|
  s.name        = "keen-cli-mixpanel"
  s.version     = KeenCli::Mixpanel::VERSION
  s.authors     = ["Terry Horner"]
  s.email       = "terry@keen.io"
  s.homepage    = "https://github.com/keenlabs/keen-cli-mixpanel"
  s.summary     = "Mixpanel plugin for Keen IO command line interface"
  s.description = "Export data from Mixpanel to Keen IO with ease"
  s.license     = "MIT"

  s.add_dependency "keen", ">= 0.8.4"
  s.add_dependency "keen-cli", ">= 0.1.8"
  s.add_dependency "thor"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'debugger'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end