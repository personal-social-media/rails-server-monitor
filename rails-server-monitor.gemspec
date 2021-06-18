# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/rails_server_monitor/version"

Gem::Specification.new do |spec|
  spec.name        = "rails-server-monitor"
  spec.version     = RailsServerMonitor::VERSION
  spec.authors     = ["Personal Social Media"]
  spec.email       = ["contact@personalsocialmedia.net"]
  spec.homepage    = "https://github.com/personal-social-media/rails-server-monitor"
  spec.summary     = "A rails engine which offers a dashboard to monitor your rails server performance"
  spec.description = "Monitor one or multiple servers at once and see stats in web UI"
  spec.license     = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/personal-social-media/rails-server-monitor"
  spec.metadata["changelog_uri"] = "https://github.com/personal-social-media/rails-server-monitor"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop-rails_config"
  spec.add_dependency "sys-cpu", "~> 1.0", ">= 1.0.3"
  spec.add_dependency "vidibus-sysinfo", "~> 1.2"
  spec.add_dependency "rails", ">= 6.0.0", "< 7"
  spec.add_dependency "webpacker", ">=6.0.0.beta.7", "< 7.0.0"
  spec.add_dependency "psm-ruby-stats", "~> 1.0", ">= 1.0.4"
end
