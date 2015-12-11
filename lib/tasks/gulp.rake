namespace :gulp do
  desc 'Run webpack'
  task :webpack => 'webpack:sync' do
    Dir.chdir 'app/webpack' do
      sh 'node_modules/.bin/gulp webpack', verbose: false do |ok, _|
        fail 'Error running webpack optimization.' unless ok
      end
    end
  end

  desc 'Run bower install through gulp'
  task :bower => 'webpack:sync' do
    Dir.chdir 'app/webpack' do
      sh 'node_modules/.bin/gulp bower', verbose: false do |ok, _|
        fail 'Error running bower install.' unless ok
      end
    end
  end

  desc 'List available gulp tasks'
  task :tasks do
    Dir.chdir 'app/webpack' do
      sh 'node_modules/.bin/gulp --tasks', verbose: false
    end
  end
end

desc 'Run gulp task specified without parameters'
task :gulp, [:name] do |_, args|
  Dir.chdir 'app/webpack' do
    cmd = ["node_modules/.bin/gulp #{args[:name]}"]
    cmd += args.extras unless args.extras.empty?
    sh cmd.join(' '), verbose: false do |ok, res|
        fail "Error running #{args[:name]} task." unless ok
    end
  end
end
