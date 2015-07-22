# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/log/level/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-log-level"
  spec.version       = Rack::Log::Level::VERSION
  spec.authors       = ["Maxim Pechnikov"]
  spec.email         = ["parallel588@gmail.com"]

  spec.summary       = %q{Rack log level.}
  spec.description   = %q{Rack log level.}
  spec.homepage      = "https://github.com/parallel588/rack-log-level."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
