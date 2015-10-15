# Maintain your gem's version:
require 'rails/webpack/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails-webpack'
  s.version     = Rails::Webpack::VERSION
  s.authors     = ['Jeong, Jiung']
  s.email       = ['ethernuiel@sanultari.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of RailsWebpackSupport.'
  s.description = 'TODO: Description of RailsWebpackSupport.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2', '>= 4.2.3'
end
