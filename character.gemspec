# -*- encoding: utf-8 -*-
require File.expand_path('../lib/character/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'character'
  gem.version       = Character::VERSION
  gem.summary       = 'Blogging app on the top of activeadmin and mongoid.'
  gem.description   = ''
  gem.license       = 'MIT'

  gem.authors       = ['Alex Kravets']
  gem.email         = 'santyor@gmail.com'
  gem.homepage      = 'https://github.com/alexkravets/character-rails'

  gem.require_paths = ['lib']
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  # Supress the warning about no rubyforge project
  gem.rubyforge_project = 'nowarning'

  gem.add_runtime_dependency 'compass-rails'
  gem.add_runtime_dependency 'mongoid_slug' #git: 'git://github.com/digitalplaywright/mongoid-slug.git'
  gem.add_runtime_dependency 'foundation-icons-sass-rails'
end