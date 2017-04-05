$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'crudable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'crudable'
  s.version     = Crudable::VERSION
  s.authors     = ['alex-lairan']
  s.email       = ['lairana@free.fr']
  s.homepage    = 'https://github.com/alex-lairan/crudable'
  s.summary     = 'Crudable simplify your CRUD controller.'
  s.description = 'Crudable simplify your CRUD controller.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails'

  s.add_development_dependency 'sqlite3'
end
