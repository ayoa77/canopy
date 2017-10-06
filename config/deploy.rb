# config valid only for current version of Capistrano
lock "3.9.1"

# set :application, "my_app_name"
# set :repo_url, "git@example.com:me/my_repo.git"

set :application, 'canopy'
set :repo_url, 'https://ayoa77:S6SMTfsmuF9vFRNeSy84@bitbucket.org/ayoa77/canopy.git'
set :branch, "mailer"

set :user, "aj"
set :use_sudo, true
set :pty, true
set :rails_env, "production"
set :deploy_via, :remote_cache
set :keep_releases, 10
server '172.104.83.111', user: 'aj', roles: %w{web app db live}
# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/canopy/'

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

# set :passenger_environment_variables, { :path => '/home/aj/.rvm/gems/ruby-2.4.1@canopy/gems/passenger-5.1.8/
# bin:$PATH' }
# set :passenger_restart_command, '/home/aj/.rvm/gems/ruby-2.4.1@canopy/gems/passenger-5.1.8
# bin/passenger-config restart-app'
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
#   task :precompile do
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
# after "deploy:cleanup", "deploy:assets:precompile"
# set the locations that we will look for changed assets to determine whether to precompile
set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)

# clear the previous precompile task
Rake::Task["deploy:assets:precompile"].clear_actions
class PrecompileRequired < StandardError; end

namespace :deploy do
  namespace :assets do
    desc "Precompile assets"
    task :precompile do
      on roles(fetch(:assets_roles)) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            begin
              # find the most recent release
              latest_release = capture(:ls, '-xr', releases_path).split[1]

              # precompile if this is the first deploy
              raise PrecompileRequired unless latest_release

              latest_release_path = releases_path.join(latest_release)

              # precompile if the previous deploy failed to finish precompiling
              execute(:ls, latest_release_path.join('assets_manifest_backup')) rescue raise(PrecompileRequired)

              fetch(:assets_dependencies).each do |dep|
                # execute raises if there is a diff
                execute(:diff, '-Naur', release_path.join(dep), latest_release_path.join(dep)) rescue raise(PrecompileRequired)
              end

              info("Skipping asset precompile, no asset diff found")

              # copy over all of the assets from the last release
              execute(:cp, '-r', latest_release_path.join('public', fetch(:assets_prefix)), release_path.join('public', fetch(:assets_prefix)))
            rescue PrecompileRequired
              execute(:rake, "assets:precompile") 
            end
          end
        end
      end
    end
  end
end


