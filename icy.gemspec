# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'icy/version'

Gem::Specification.new do |spec|
  spec.name          = "icy"
  spec.version       = Icy::VERSION
  spec.authors       = ["Austin Schneider"]
  spec.email         = ["me@austinschneider.com"]

  spec.summary       = 'A toolkit of classes and methods'
  spec.homepage      = "https://github.com/austinthecoder/icy"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 12"
end
