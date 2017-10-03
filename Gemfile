source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'test-unit'
gem 'minitest'
gem 'rubocop'
# spree gems
gem 'spree_dynamic_variants', github: 'hefan/spree_dynamic_variants', branch: 'master'
gem 'spree_mail_settings', github: 'spree-contrib/spree_mail_settings'
gem 'spree', '~> 3.3.0.rc1'
gem 'spree_auth_devise', '~> 3.3.0.rc1'
gem 'spree_gateway', '~> 3.3.0.rc1'
#for internationalization, language and currency
gem 'spree_i18n', github: 'spree-contrib/spree_i18n'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use this gem to connect with AllPAy
gem 'active_merchant_allpay', github: 'imgarylai/active_merchant_allpay'
gem 'allpay-web-service'
# gem 'activemerchant'
# gem 'active_merchant_allpay'
# gem 'allpay_payment-2.0.8', github: 'allPay/allPayAIO_Ruby'
# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails', :require => false
  gem 'capistrano-bundler', :require => false
  gem 'capistrano', :require => false
  gem 'capistrano-unicorn-nginx', '~> 4.1.0', :require => false
  gem 'capistrano-rvm', :require => false
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri, :require => false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0', :require => false
  gem 'listen', '~> 3.0.5', :require => false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', :require => false
  gem 'spring-watcher-listen', '~> 2.0.0', :require => false
end

group :production do
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
