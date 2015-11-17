# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avro2kafka/version'

Gem::Specification.new do |spec|
  spec.name          = "avro2kafka"
  spec.version       = Avro2Kafka::VERSION
  spec.authors       = ["Peter Marton", "Tamas Michelberger", "Gabor Ratky"]
  spec.email         = ["martonpe@secretsaucepartners.com", "tomi@secretsaucepartners.com", "gabor@secretsaucepartners.com"]
  spec.summary       = %q{Publish Avro files to Kafka}
  spec.description   = %q{Publish Avro files to Kafka in JSON format}
  spec.homepage      = "https://github.com/sspinc/avro2kafka"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "bump", "~> 0.5"

  spec.add_runtime_dependency "avro", "~> 1.7"
  spec.add_runtime_dependency "poseidon", "~> 0.0.5"
  spec.add_runtime_dependency "logr", "~> 0.1.0"
end
