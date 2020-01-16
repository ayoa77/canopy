# config valid only for current version of Capistrano
lock "3.11.2"

# set :application, "my_app_name"
# set :repo_url, "git@example.com:me/my_repo.git"
  # SSHKit.config.command_map[:git] = 'sudo git'
  # SSHKit.config.command_map[:mkdir] = 'sudo mkdir'
  # SSHKit.config.command_map[:tar] = 'sudo tar'
  # SSHKit.config.command_map[:echo] = 'sudo echo'
  # SSHKit.config.command_map[:rm] = 'sudo rm'
  # SSHKit.config.command_map[:ln] = 'sudo ln'
  # # SSHKit.config.command_map[:bundle] = 'sudo bundle'
  SSHKit.config.command_map[:rm] = 'sudo rm'
  # SSHKit.config.command_map[:default] = 'sudo default'
  # SSHKit.config.command_map['~/.rvm/bin/rvm'] = 'sudo ~/.rvm/bin/rvm'
  # MONKEY PATCH OH NO
  # =======================

  # you actually have to clear the old rake task 
  # for yours to overwrite Capistrano's
  Rake::Task['deploy:set_current_revision'].clear
  desc "IT'S MINE"
  task :set_current_revision do
    on release_roles(:all) do
      within release_path do
        execute :echo, "\"$(sudo -u deployuser git rev-parse HEAD)\" | sudo -u deployuser tee REVISION"
      end
    end
  end


  Rake::Task['deploy:log_revision'].clear
  desc "Log details of the deploy"
  task :log_revision do
    on release_roles(:all) do
      within releases_path do
        execute :echo, %Q{"#{revision_log_message}" | sudo -u deployuser tee #{revision_log}}
      end
    end
  end


set :application, 'canopy'
set :repo_url, 'https://github.com/ayoa77/canopy.git'
set :branch, "master"

server 'flexstudio.io', user: 'ayo'
# server 'flexstudio.io', user: 'ayo', roles: %w{web app db live}, use_sudo: true
set :user, "ayo"
set :use_sudo, true
set :pty, true
# default_tasks[:pty] = true  
set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 3
# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/canopy/'

role :app, %w{flexstudio.io}
role :web, %w{flexstudio.io}
role :db,  %w{flexstudio.io}
role :live, %w{flexstudio.io}
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false

set :ssh_options, {:forward_agent => true}

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"
# append :linked_files, "config/application.yml", "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "public/spree", "tmp/pids", "tmp/cache", "public/system", "public/javascripts" 

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" } rsync -zvh database.yml aj@172.104.83.111.com:~/var/www/html/canopy/shared/config/

# set :passenger_environment_variables, { :path => '/var/www/canopy/current' }
 set :passenger_restart_command, 'passenger-config restart-app --ignore-passenger-not-running'
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# namespace :bundle do
#     desc "Bundling gems"
#     task :install do
#       on roles(:app) do
#         execute "bundle install"
#       end
#     end
# end
# after "bundler:install", "bundle:install"

task :symlink_database_yml do
    on roles(:app) do
        execute "rm #{release_path}/config/database.yml"
        execute "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
        end
end
#  after "bundler:install", "symlink_database_yml"

# namespace :unicorn do
#   desc "Zero-downtime restart of Unicorn"
#   task :restart do
#       on roles(:app) do
#         execute "kill -s USR2 `cat /tmp/unicorn.canopy.pid`"
#         end
#   end

#   desc "Start unicorn"
#   task :start do
#       on roles(:app) do
#         execute "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
#         end
#   end

#   desc "Stop unicorn"
#   task :stop do
#       on roles(:app) do
#         execute "kill -s QUIT `cat /tmp/unicorn.canopy.pid`"
#         end
#   end
# end
# after "symlink_database_yml", "unicorn:start"


namespace :images do
  task :symlink do
      on roles(:app) do
        execute "rm -rf #{release_path}/public/canopy"
        execute "ln -nfs #{shared_path}/canopy #{release_path}/public/canopy"
        end
  end
end
# after 'deploy:assets:precompile', 'deploy:assets:gzip'
#  after "bundler:install", "symlink_database_yml"
#  after "bundler:install", "images:symlink"
# namespace :deploy do
#   namespace :assets do
#    desc "Precompile assets locally and then rsync to deploy server"
#     task :precompile, :only => { :primary => true } do
#       run_locally "bundle exec rake assets:precompile"
#       servers = find_servers :roles => [:app], :except => { :no_release => true }
#       servers.each do |server|
#         run_locally "rsync -av ./public/#{assets_prefix}/ #{user}@#{server}:#{current_path}/public/#{assets_prefix}/"
#       end
#       run_locally "rm -rf public/#{assets_prefix}"
#     end
#   end
# end

# namespace :deploy do
#   after :updated, "assets:precompile"
# end

# namespace :assets do
#   desc "Precompile assets locally and then rsync to web servers"
#   task :precompiler do
#     on roles(:web) do
#       rsync_host = host.to_s # this needs to be done outside run_locally in order for host to exist
#       run_locally do
#         with rails_env: fetch(:stage) do
#           execute :bundle, "exec rake assets:precompile"
#         end
#         execute "rsync -av --delete ./public/assets/ #{fetch(:user)}@#{rsync_host}:#{shared_path}/public/assets/"
#         execute "rm -rf public/assets"
#         # execute "rm -rf tmp/cache/assets" # in case you are not seeing changes
#       end
#     end
#   end
# end
# after "deploy:assets:precompile", "deploy:assets:precompiler"


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Restarts Phusion Passenger
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

end
after "deploy:cleanup", "deploy:restart"

