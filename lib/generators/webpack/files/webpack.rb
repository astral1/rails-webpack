Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'compiled')
Rails.application.config.webpack = Rails::Webpack::Config
