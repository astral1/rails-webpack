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

    processor.flush
  end

  private
  def process_line(fqn, matcher, category, node, depth, collections, new_contents)
    return false unless fqn.start_with? matcher
    return true unless depth == 1
    log :webpack, "dependencies.#{category.to_s}"
    replace_dependencies(collections, category, node, new_contents)
    true
  end
  
  def replace_dependencies(collections, category, text, new_contents)
    deps = collections.yamlize(category)
    new_contents << "  #{text}:#{' []' if deps.blank?}"
    new_contents << collections.yamlize(category) unless deps.blank?
  end
end
