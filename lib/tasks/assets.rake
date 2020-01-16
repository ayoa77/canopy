# Place this code in lib/tasks/assets.rake
# namespace :assets do
#   desc "Create .gz versions of assets"
#   task :gzip => :environment do
#     zip_types = /\.(?:css|html|js|otf|svg|txt|xml)$/

#     public_assets = File.join(
#       Rails.root,
#       "public",
#       Rails.application.config.assets.prefix)

#     Dir["#{public_assets}/**/*"].each do |f|
#       next unless f =~ zip_types

#       mtime = File.mtime(f)
#       gz_file = "#{f}.gz"
#       next if File.exist?(gz_file) && File.mtime(gz_file) >= mtime

#       File.open(gz_file, "wb") do |dest|
#         gz = Zlib::GzipWriter.new(dest, Zlib::BEST_COMPRESSION)
#         gz.mtime = mtime.to_i
#         IO.copy_stream(open(f), gz)
#         gz.close
#       end

#       File.utime(mtime, mtime, gz_file)
#     end
#   end

#   # Hook into existing assets:precompile task
#   Rake::Task["assets:precompile"].enhance do
#     Rake::Task["assets:gzip"].invoke
#   end
# end

# lib/tasks/assets.rake
namespace :assets do
  # desc "Precompile assets locally and then rsync to web servers"
  # task :precompiler do
  #   on roles(:web) do
  #     rsync_host = host.to_s # this needs to be done outside run_locally in order for host to exist
  #     run_locally do
  #       with rails_env: fetch(:stage) do
  #         execute :bundle, "exec rake assets:precompile"
  #       end
  #       execute "rsync -av --delete ./public/assets/ #{fetch(:user)}@#{rsync_host}:#{shared_path}/public/assets/"
  #       execute "rm -rf public/assets"
  #       # execute "rm -rf tmp/cache/assets" # in case you are not seeing changes
  #     end
  #   end
  # end
  task :gzip do
    require 'zlib'

    Dir['public/assets/**/*.{css|js|otf|svg|txt|xml|jpg|png|jpeg}'].each do |path|
      gz_path = "#{path}.gz"
      next if File.exist?(gz_path)

      Zlib::GzipWriter.open(gz_path) do |gz|
        gz.mtime = File.mtime(path)
        gz.orig_name = path
        gz.write(IO.binread(path))
      end
    end
  end
end