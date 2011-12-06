# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "processctl/version"

Gem::Specification.new do |s|
  s.name        = "processctl"
  s.version     = Processctl::VERSION
  s.authors     = ["Stefan Huber"]
  s.email       = ["stefan.huber@friendscout24.de"]
  s.homepage    = ""
  s.summary     = %q{Start any process as a daemon}
  s.description = %q{In search for a JRuby daemonize}

  s.rubyforge_project = "processctl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
