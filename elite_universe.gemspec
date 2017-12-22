$:.push File.expand_path("../lib", __FILE__)

require "elite_universe/version"

Gem::Specification.new do |s|
  s.name        = "elite_universe"
  s.version     = EliteUniverse::VERSION
  s.authors     = ["Joe Haig"]
  s.email       = ["joe.haig@bbc.co.uk"]
  s.homepage    = "https://github.com/jrmhaig/elite_universe"
  s.summary     = "Elite Universe"
  s.description = "Implementation of the Acornsoft Elite planet generator algorithm."
  s.license     = "MIT"

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']

  s.add_development_dependency 'rspec', '~> 3.7'
end
