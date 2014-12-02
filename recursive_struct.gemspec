# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ostruct'
require 'recursive_struct/version'

Gem::Specification.new do |spec|
  spec.name          = "recursive_struct"
  spec.version       = RecursiveStruct::VERSION
  spec.authors       = ["Phillip Boksz"]
  spec.email         = ["pboksz@gmail.com"]
  spec.summary       = "A gem to create recursive open structs."
  spec.description   = "A gem to create recursive open structs."
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/pboksz/recursive_struct"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0"
  spec.add_development_dependency "rspec", "~> 2"
end
