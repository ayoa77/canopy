# config valid only for current version of Capistrano
lock "3.9.1"

# set :application, "my_app_name"
# set :repo_url, "git@example.com:me/my_repo.git"

set :application, 'canopy'
set :repo_url, 'https://ayoa77:S6SMTfsmuF9vFRNeSy84@bitbucket.org/ayoa77/canopy.git'
set :branch, "master"

set :user, "aj"
set :pty, true
set :rails_env, "production"
set :deploy_via, :remote_cache
set :keep_releases, 10
server '172.104.83.111', user: 'aj', roles: %w{web app db live}
# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/aj/var/www/html/canopy/'

role :app, %w{172.104.83.111}
role :web, %w{172.104.83.111}
role :db,  %w{172.104.83.111}
role :live, %w{172.104.83.111}
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
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"
# append :linked_files, "config/application.yml", "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "tmp/pids", "tmp/cache", "public/system", "public/javascripts"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" } rsync -zvh database.yml aj@172.104.83.111.com:~/var/www/html/canopy/shared/config/

/home/aj/.rvm/gems/ruby-2.4.1@canopy/gems/passenger-5.1.8
set :passenger_environment_variables, { :path => '/home/aj/.rvm/gems/ruby-2.4.1@canopy/gems/passenger-5.1.8
bin:$PATH' }
set :passenger_restart_command, '/home/aj/.rvm/gems/ruby-2.4.1@canopy/gems/passenger-5.1.8
bin/passenger-config restart-app'
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 10

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
#  after "bundler:install", "symlink_database_yml"
#  after "bundler:install", "images:symlink"

