# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bigbrotha/version'

Gem::Specification.new do |spec|
  spec.name          = "bigbrotha"
  spec.version       = BigBrotha::VERSION
  spec.authors       = ["WF | Snezhana Dichevska"]
  spec.email         = ["snezhana.dichevska@webfactory.mk"]

  spec.summary       = %q{Allows you to keep track of posts with taboo words and manage them through admin panel.}
  spec.description   = %q{You can censor all comments and descriptions and any string that should be censored and keep track of the posts that contain taboos and users that used them via admin panel.}
  spec.homepage      = "http://sorrynohomepage.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
