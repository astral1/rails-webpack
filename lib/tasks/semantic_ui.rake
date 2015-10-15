namespace :prepare do
  desc 'Prepare Semantic UI'
  task :semantic do
    Dir.chdir 'app/webpack' do
      sh 'gulp semantic-ui' do |ok, _|
        fail 'Error in installing semantic-ui theme' unless ok
      end
    end
  end
end

Rake::Task['prepare:webpack'].enhance ['prepare:semantic']
