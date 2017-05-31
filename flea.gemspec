# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flea/version'

Gem::Specification.new do |spec|
  spec.name          = "flea"
  spec.version       = Flea::VERSION
  spec.authors       = ["Aaron Gough"]
  spec.email         = ["aaron@aarongough.com"]

  spec.summary       = %q{A tiny but flexible Lisp interpreter written in Ruby}
  spec.description   = %q{Flea is an extremely simple, but extremely extensible Lisp interpreter written in Ruby.}
  spec.homepage      = "https://github.com/aarongough/flea"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sexpistol"

  spec.add_development_dependency "any-spec"
  spec.add_development_dependency "rspec", "~> 3.2"
end