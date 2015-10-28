module Rails
  module Webpack
    require 'rails/webpack/version'
    require 'rails/webpack/railtie'
    autoload :DependencyCollection, 'rails/webpack/dependency_collection'
    autoload :Processor, 'rails/webpack/processor'
    autoload :Config, 'rails/webpack/config'
    autoload :Actions, 'rails/webpack/actions'
  end
end
