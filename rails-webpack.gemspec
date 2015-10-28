$:.unshift File.expand_path('lib', __dir__)
# Maintain your gem's version:
require 'rails/webpack/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails-webpack'
  s.version     = Rails::Webpack::VERSION
  s.authors     = ['Jeong, Jiung']
  s.email       = ['ethernuiel@sanultari.com']
  s.homepage    = 'https://github.com/astral1/rails-webpack'
  s.summary     = 'Rails Plugin for webpack support'
  s.description = 'Rails Plugin for webpack support'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2', '>= 4.2.3'
  s.add_dependency 'settingslogic', '~> 2.0', '>= 2.0.9'
end
