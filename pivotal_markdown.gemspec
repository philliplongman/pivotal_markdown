# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivotal_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = "pivotal_markdown"
  spec.version       = PivotalMarkdown::VERSION
  spec.authors       = ["Phillip Longman"]
  spec.email         = ["himself@philliplongman.com"]

  spec.summary       = %q{Write stories in Markdown, upload them to Pivotal Tracker on the command line.}
  spec.description   = %q{Write stories in Markdown, upload them to Pivotal Tracker on the command line.}
  spec.homepage      = "https://github.com/philliplongman/pivotal_markdown"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "tracker_api", "~> 1.2.1"
  spec.add_dependency "pivotal-tracker", "~> 0.5.13"

  spec.add_development_dependency "awesome_print", "~> 1.7.0"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "fuubar", "~> 2.2.0"
  spec.add_development_dependency "coveralls", "~> 0.8.15"
end
