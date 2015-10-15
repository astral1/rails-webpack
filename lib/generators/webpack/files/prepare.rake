namespace :prepare do
  desc 'Prepare static resources with webpack'
  task :webpack => %w(npm:install gulp:webpack)
end

Rake::Task['assets:precompile'].enhance ['prepare:webpack']
