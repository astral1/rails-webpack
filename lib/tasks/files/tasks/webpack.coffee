webpack = (gulp, plugins, root) ->
  path = require 'path'
  webpack = require 'webpack'
  stream = require 'webpack-stream'
  named = require 'vinyl-named-with-path'
  () ->
    gulp.src('src/pages/**.coffee')
      .pipe(named())
      .pipe(stream(
        resolve:
          root: [root, path.join(root, "bower_components"), path.join(root, 'src')]
        output:
          filename: '[name].bundle.js'
        module:
          loaders: [
            #{ test: /\.css$/, loader: 'style!css' },
            { test: /\.coffee$/, loader: 'coffee' },
            { test: /\.(coffee\.md|litcoffee)$/, loader: 'coffee?literate' },
            { test: /\.less$/, loader: 'style!css!less' }
          ]
        plugins: [
          new webpack.ResolverPlugin([
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('package.json', ['main']),
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
          ]),
          new webpack.optimize.CommonsChunkPlugin(
            name: 'core'
            filename: 'core.bundle.js'
            async: true
            minChunks: 2
          )
        ]
      ))
      .pipe(gulp.dest(path.join root, '../assets/compiled/'))
    return null

module.exports = webpack
