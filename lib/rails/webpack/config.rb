require 'settingslogic'

class Rails::Webpack::Config < Settingslogic
  source Rails.root.join('config', 'webpack.yml')

  def npm_configured?(key)
    keys.include?('npm') && npm.keys.include?(key.to_s)
  end

  def bower_configured?(key)
    keys.include?('bower') && bower.keys.include?(key.to_s)
  end
end
