module Webpack
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('files', __dir__)

    def install_tasks
      copy_file 'npm.rake', 'lib/tasks/npm.rake'
      copy_file 'gulp.rake', 'lib/tasks/gulp.rake'
      copy_file 'prepare.rake', 'lib/tasks/prepare.rake'
      copy_file 'webpack.rake', 'lib/tasks/webpack.rake'
    end

    def run_init
      rake 'webpack:init'
    end

    def run_sync
      rake 'webpack:sync'
    end
  end
end
