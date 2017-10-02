task :symlink_database_yml do
  run "rm #{release_path}/config/database.yml"
  run "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
#  after "deploy:bundle", "symlink_database_yml"

namespace :unicorn do
  desc "Zero-downtime restart of Unicorn"
  task :restart do
    run "kill -s USR2 `cat /tmp/unicorn.canopy.pid`"
  end

  desc "Start unicorn"
  task :start do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop do
    run "kill -s QUIT `cat /tmp/unicorn.canopy.pid`"
  end
end


namespace :images do
  task :symlink do
    run "rm -rf #{release_path}/public/canopy"
    run "ln -nfs #{shared_path}/canopy #{release_path}/public/canopy"
  end
end
# after "deploy:bundle", "images:symlink"