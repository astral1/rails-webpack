load_tasks = (gulp, plugins, options) ->
  walk_sync = require 'walk-sync'
  path = require 'path'
  options ||= {}
  options['root'] ||= __dirname
  options['dependencies'] ||= {}

  nodes = walk_sync('./tasks', { globs: ['**/*.coffee'] });

  for node in nodes
    ext = path.extname node
    name = node.replace ext, ''
    if options.dependencies[name] instanceof Array
      gulp.task name, options.dependencies[name], require(['./tasks', name].join('/'))(gulp, plugins, options.root)
    else
      gulp.task name, require(['./tasks', name].join('/'))(gulp, plugins, options.root)

module.exports = load_tasks
