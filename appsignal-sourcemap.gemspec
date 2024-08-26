# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "appsignal/sourcemap/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "appsignal-sourcemap"
  spec.version = Appsignal::Sourcemap::VERSION
  spec.authors = ["Drieam"]
  spec.email = ["dev@drieam.com"]
  spec.homepage = "https://github.com/drieam/appsignal-sourcemap"
  spec.summary = "Upload private sourcemaps to appsignal"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/Drieam"

  spec.required_ruby_version = ">= 3.1"

  spec.files = Dir["lib/**/*", "README.md"]

  spec.add_dependency "rails", ">= 6.1", "< 8.0"
  spec.add_dependency "appsignal", "< 5.0"
  spec.add_dependency "parallel", "~> 1.0"

  spec.add_development_dependency "standard"
  spec.metadata["rubygems_mfa_required"] = "true"
end
