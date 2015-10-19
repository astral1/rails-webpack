module Webpack
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('files', __dir__)

    def run_init
      rake 'webpack:init'
    end

    def run_sync
      rake 'webpack:sync'
    end
  end
end
