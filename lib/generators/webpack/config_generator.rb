module Webpack
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path(__dir__)

    def change_rails_context
      gsub_file 'Rakefile', 'require File.expand_path(\'../config/application\', __FILE__)', 'require_realtive \'config/environment\''
    end

    def init_config
      copy_file 'files/webpack.rb', 'config/initializers/webpack.rb'
      if File.exist? Rails.root.join('config', 'webpack.yml')
        log :skipped, 'config/webpack.yml'
      else
        template 'templates/webpack.yml.erb', 'config/webpack.yml' 
      end

      puts 'Ready for webpack! Configure with config/webpack.yml.'
    end
  end
end
