module Rails::Webpack::Actions
  def dependencies(&block)
    collections = Rails::Webpack::DependencyCollection.new Rails::Webpack::Config
    collections.instance_eval &block
    processor = collections.processor

    processor.process([
      {
        matcher: 'bower.dependencies',
        category: :bower,
        text: 'dependencies'
      },
      {
        matcher: 'npm.dependencies',
        category: :npm,
        text: 'dependencies'
      },
      {
        matcher: 'npm.develop_dependencies',
        category: :npm_develop,
        text: 'develop_dependencies'
      }
    ])

    log :webpack, 'config/webpack.yml'
    processor.flush
  end
end
