# encoding: UTF-8

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'grape/client-generator/version'

Gem::Specification.new do |s|
  s.name     = "grape-client-generator"
  s.version  = ::Grape::ClientGenerator::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = ""

  s.description = s.summary = "Automatically generate clients for your Grape APIs."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'mustache'
  s.require_path = 'lib'

  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "LICENSE", "README.md", "Rakefile", "grape-client-generator.gemspec"]
end
