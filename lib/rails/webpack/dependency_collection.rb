require 'rails/generators/actions'

class Rails::Webpack::DependencyCollection
  include Rails::Generators::Actions

  VALID_CATEGORY = [:bower, :npm, :npm_develop]

  class << self
    def collection_name_from(category)
      "#{category.to_s}_deps"
    end
  end

  VALID_CATEGORY.each do |category|
    attr_reader collection_name_from(category).to_sym
    define_method category do |name, version_spec|
      add category, name, version_spec
    end
  end

  def initialize(config)
    @config, @file = config, config.source.to_s
    @bower_deps = normalize @config.bower.dependencies
    @npm_deps = normalize @config.npm.dependencies
    @npm_develop_deps = normalize @config.npm.develop_dependencies
  end

  def add(category, name, version_spec)
    deps = get(category)
    deps << {'name' => name, 'version' => version_spec}
    deps.uniq!
  end

  def yamlize(category)
    get(category).to_yaml.lines[1..-1].map(&:rstrip).join("\n").gsub('"', "'").gsub /^/, (' ' * 4)
  end

  def processor
    Rails::Webpack::Processor.new(@file, self)
  end

  private
  def normalize(hashes)
    hashes.map {|d| {}.merge d}
  end

  def get(category)
    sanitize! category
    send collection_name_from(category)
  end

  def sanitize!(category)
    error = "The specified category is invalid. valid categories are in [#{VALID_CATEGORY.to_s}]"
    raise error unless VALID_CATEGORY.include?(category)
  end

  def collection_name_from(category)
    self.class.collection_name_from(category)
  end
end
