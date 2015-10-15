webpack = (gulp, plugins, root) ->
  path = require 'path'
  webpack = require 'webpack'
  (callback) ->
    #run webpack
    webpack(
      resolve:
        root: [root, path.join(root, "bower_components"), path.join(root, 'src')]
      entry:
        common: 'pages/common.coffee'
        devise: 'pages/devise.coffee'
      output:
        path: path.join root, '../assets/compiled/'
        filename: '[name].bundle.js'
      module:
        loaders: [
          #{ test: /\.css$/, loader: 'style!css' },
          { test: /\.coffee$/, loader: 'coffee' },
          { test: /\.(coffee\.md|litcoffee)$/, loader: 'coffee?literate' },
          { test: /\.less$/, loader: 'style!css!less' }
        ]
      plugins: [
        new webpack.ResolverPlugin(
          new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
        )
      ],
      (err, stats) ->
        throw new gutil.PluginError('webpack', err) if(err)
        plugins.util.log('[webpack]', stats.toString())
        callback())
    return null

module.exports = webpack
