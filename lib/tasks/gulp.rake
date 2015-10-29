namespace :gulp do
  desc 'Run webpack'
  task :webpack => 'webpack:sync' do
    Dir.chdir 'app/webpack' do
      sh 'gulp webpack' do |ok, _|
        fail 'Error running webpack optimization.' unless ok
      end
    end
  end

  desc 'Run bower install through gulp'
  task :bower => 'webpack:sync' do
    Dir.chdir 'app/webpack' do
      sh 'gulp bower' do |ok, _|
        fail 'Error running bower install.' unless ok
      end
    end
  end
end

desc 'Run gulp task specified without parameters'
task :gulp, [:name] do |_, args|
  Dir.chdir 'app/webpack' do
    sh "gulp #{args[:name]}" do |ok, _|
        fail "Error running #{args[:name]} task." unless ok
    end
  end
end
