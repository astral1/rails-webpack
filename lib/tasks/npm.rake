namespace :npm do
  desc 'Run npm install'
  task :install => 'webpack:sync' do
    Dir.chdir 'app/webpack' do
      sh 'npm install' do |ok, _|
        fail 'Error running npm install.' unless ok
      end
    end
  end

  desc 'Clean npm node_modules'
  task :clean do
    Dir.chdir 'app/webpack' do
      FileUtils.rm_rf 'node_modules'
    end
  end

  namespace :install do
    desc 'Run a clean npm install'
    task :clean => %w(npm:clean npm:install)
  end
end
