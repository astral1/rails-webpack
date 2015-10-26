module Rails::Webpack::Actions
  def dependencies(&block)
    collections = Rails::Webpack::DependencyCollection.new Rails::Webpack::Config
    collections.instance_eval &block
    file = Rails::Webpack::Config.source.to_s

    contents = File.read file

    new_contents = []
    current_scope = []
    depth = 0
    indent = ' ' * 2
    contents.lines.each do |line|
      if line.match(/^\s*#/)
        new_contents << line.rstrip
        next
      end
      depth = line.match(/(^(#{indent}){0,})/)[1].length / indent.length
      name = line.split(':').first.strip
      current_scope[depth] = name
      fqn = current_scope[0, depth + 1].join('.')
      if fqn.start_with?('bower.dependencies')
        next unless depth == 1
        replace_dependencies(collections, :bower, 'dependencies', new_contents)
        next
      end
      if fqn.start_with?('npm.dependencies')
        next unless depth == 1
        replace_dependencies(collections, :npm, 'dependencies', new_contents)
        next
      end
      if fqn.start_with?('npm.develop_dependencies')
        next unless depth == 1
        replace_dependencies(collections, :npm_develop, 'develop_dependencies', new_contents)
        next
      end
      new_contents << line.rstrip
    end
    new_contents.join("\n")
  end

  private
  def replace_dependencies(collections, category, text, new_contents)
    deps = collections.yamlize(category)
    new_contents << "  #{text}:#{' []' if deps.blank?}"
    new_contents << collections.yamlize(category) unless deps.blank?
  end
end
