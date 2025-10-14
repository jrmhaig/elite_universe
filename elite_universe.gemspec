# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'elite_universe/version'

Gem::Specification.new do |s|
  s.name                  = 'elite_universe'
  s.version               = EliteUniverse::VERSION
  s.authors               = ['Joe Haig']
  s.email                 = ['joseph.haig@gmail.com']
  s.homepage              = 'https://github.com/jrmhaig/elite_universe'
  s.summary               = 'Elite Universe'
  s.description           = 'Implementation of the Acornsoft Elite planet generator algorithm.'
  s.license               = 'MIT'
  s.required_ruby_version = '>= 3.2'

  s.files = Dir['lib/**/*', 'LICENSE', 'README.md']

  s.metadata['rubygems_mfa_required'] = 'true'
end
