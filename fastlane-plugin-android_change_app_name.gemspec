# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/android_change_app_name/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-android_change_app_name'
  spec.version       = Fastlane::AndroidChangeAppName::VERSION
  spec.author        = %q{MaximusMcCann}
  spec.email         = %q{mxmccann@gmail.com}

  spec.summary       = %q{Changes the manifest's label attribute (appName).  Stores the original name for revertinng.}
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-android_change_app_name"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.106.2'
end
