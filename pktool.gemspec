# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "pktool"
  spec.version       = Pktool::VERSION
  spec.authors       = ["uzimith"]
  spec.email         = ["uzimith.x9@gmail.com"]
  spec.description   = %q{pokemon battle support tool}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "bundler", "~> 1.3"
  spec.add_runtime_dependency "rake", "~> 10.4.1"
  spec.add_runtime_dependency "activerecord", "~> 4.2.1"
  spec.add_runtime_dependency "sqlite3", "~> 1.3.10"
  spec.add_runtime_dependency "termcolorlight", "~> 1.1.1"
  spec.add_runtime_dependency "thor", "~> 0.19.1"
  spec.add_runtime_dependency "romaji", "~>0.2.1"
end
