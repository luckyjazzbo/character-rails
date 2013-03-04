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

  # assets
  gem.add_runtime_dependency 'codemirror-rails'
  gem.add_runtime_dependency 'compass-rails'
  gem.add_runtime_dependency 'zurb-foundation'
  gem.add_runtime_dependency 'jquery-ui-rails'
  gem.add_runtime_dependency 'foundation-icons-sass-rails'
  gem.add_runtime_dependency 'font-awesome-sass-rails'
  gem.add_runtime_dependency 'fog'
  gem.add_runtime_dependency 'carrierwave-mongoid'
  gem.add_runtime_dependency 'lodash-rails', '~> 0.10.0'
  gem.add_runtime_dependency 'underscore-string-rails'
  
  # mongoid
  gem.add_runtime_dependency 'mongoid_slug'

  # browserid auth
  gem.add_runtime_dependency 'browserid-auth-rails'

  # meta tags support
  gem.add_runtime_dependency 'meta-tags'

  # forms
  gem.add_runtime_dependency 'simple_form'

  # language support
  gem.add_runtime_dependency 'whatlanguage'
  gem.add_runtime_dependency 'russian'


  #gem.add_runtime_dependency 'mongoid_slug' #git: 'git://github.com/digitalplaywright/mongoid-slug.git'
  #gem.add_runtime_dependency 'kaminari'

  #gem 'rmagick'
  #gem "carrierwave-mongoid",  require: "carrierwave/mongoid", git: "git://github.com/jnicklas/carrierwave-mongoid.git", branch: "mongoid-3.0"
end