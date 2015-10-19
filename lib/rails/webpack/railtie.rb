require 'rails/webpack'
require 'rails'

module Rails::Webpack
  class Railtie < Rails::Railtie
    railtie_name :'rails-webpack'

    rake_tasks do
      load 'tasks/gulp.rake'
      load 'tasks/npm.rake'
      load 'tasks/prepare.rake'
      load 'tasks/webpack.rake'
    end
  end
end
