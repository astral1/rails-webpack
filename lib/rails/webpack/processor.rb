class Rails::Webpack::Processor
  def initialize(file, collections)
    @contents = File.read(file).lines.map(&:rstrip)
    @file = file
    @collections = collections
    @generated = []
    @scope = []
    @depth = 0
    @indent = ' ' * 2
  end

  def process(config_list)
    @contents.each do |line|
      next if comments(line)
      next if blank_lines(line)
      @depth = line.match(/(^(#{@indent}){0,})/)[1].length / @indent.length
      @scope[@depth] = line.split(':').first.strip
      @fullname = @scope[0, @depth + 1].join('.')
      next if process_configs(config_list)
      @generated << line
    end
  end

  def flush
    File.write @file, @generated.join("\n")
  end

  private
  def process_configs(config_list)
    config_list.each do |config|
      return true if process_line(config)
    end
    false
  end

  def process_line(config)
    return false unless @fullname.start_with? config[:matcher]
    return true unless @depth == (config[:matcher].split('.').length - 1)
    replace(config)
    true
  end

  def comments(line)
    return false unless line.match(/^\s*#/)
    @generated << line
    true
  end

  def replace(config)
    deps = @collections.yamlize(config[:category])
    @generated << "  #{config[:text]}:#{' []' if deps.blank?}"
    @generated << deps unless deps.blank?
  end

  def blank_lines(line)
    return false unless line.match(/^\s*$/)
    @generated << line
    true
  end
end
