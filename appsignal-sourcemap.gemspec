# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "appsignal/sourcemap/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "appsignal-sourcemap"
  spec.version = Appsignal::Sourcemap::VERSION
  spec.authors = ["Stef Schenkelaars"]
  spec.email = ["stef.schenkelaars@gmail.com"]
  spec.homepage = "https://github.com/drieam/appsignal-sourcemap"
  spec.summary = "Upload private sourcemaps to appsignal"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/Drieam"

  spec.required_ruby_version = ">= 2.7"

  spec.files = Dir["lib/**/*", "README.md"]

  spec.add_dependency "appsignal", "~> 3.0"

  spec.add_development_dependency "standard"
end
