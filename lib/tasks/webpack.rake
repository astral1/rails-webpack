require 'thor'
require 'rails/generators'

namespace :webpack do
  class Webpack < Rails::Generators::Base
    source_root File.expand_path(__dir__)
  end

  def thor(*args, &blk)
    Webpack.new.send *args, &blk
  end

  desc 'Initialize Webpack environments'
  task :init do
    thor :empty_directory, 'app/webpack/src/pages'
    thor :copy_file, 'files/src/page.common.coffee', 'app/webpack/src/pages/common.coffee'

    thor :gsub_file, 'config/initializers/assets.rb', /(version\s=\s)["'][0-9]+(\.[0-9]+)*["']$/, "\\1'#{Rails.application.config.webpack.version}'"
    thor :copy_file, 'files/tasks.coffee', 'app/webpack/tasks.coffee'
    thor :copy_file, 'files/tasks/bower.coffee', 'app/webpack/tasks/bower.coffee'
    if File.exist? 'app/webpack/tasks/webpack.coffee'
      thor :log, :unmanaged, 'app/webpack/tasks/webpack.coffee'
    else
      thor :copy_file, 'files/tasks/webpack.coffee', 'app/webpack/tasks/webpack.coffee' 
    end
  end

  desc 'Sync configurations with webpack'
  task :sync do
    thor :template, 'templates/package.json.erb', 'app/webpack/package.json', force: true
    thor :template, 'templates/bower.json.erb', 'app/webpack/bower.json', force: true
    thor :template, 'templates/gulpfile.js.erb', 'app/webpack/gulpfile.js', force: true
    thor :template, 'templates/gulpfile.coffee.erb', 'app/webpack/gulpfile.coffee' unless File.exist? 'app/webpack/gulpfile.coffee'
  end
end
