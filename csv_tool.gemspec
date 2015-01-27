# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_tool/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_tool"
  spec.version       = CsvTool::VERSION
  spec.authors       = ["John Terry"]
  spec.email         = ["jpterry@gmail.com"]
  spec.summary       = %q{Helpful csv toolkit}
  spec.description   = %q{Helpful csv tools}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "pry" "~> 0.10.1"

  spec.add_development_dependency "bundler", "~> 1.7"
end