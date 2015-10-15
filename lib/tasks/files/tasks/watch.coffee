watch = (gulp, plugins) ->
  () ->
    gulp.watch 'src/**/*', ['webpack']

module.exports = watch
