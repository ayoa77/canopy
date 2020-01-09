# lib/capistrano/tasks/assets.rake
namespace :deploy do
  namespace :assets do
    task :gzip do
      on roles(:web) do
        within release_path do
          execute :bundle, 'exec rake assets:gzip RAILS_ENV=production'
        end
      end
    end
  end
end