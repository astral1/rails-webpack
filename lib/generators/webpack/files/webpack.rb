require 'settingslogic'

class WebpackConfig < Settingslogic
  source Rails.root.join('config', 'webpack.yml')

  def npm_configured?(key)
    keys.include?('npm') && npm.keys.include?(key.to_s)
  end

  def bower_configured?(key)
    keys.include?('bower') && bower.keys.include?(key.to_s)
  end
end

Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'compiled')
Rails.application.config.webpack = WebpackConfig
