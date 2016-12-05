ruby '2.3.3'
source 'https://rubygems.org'

gem 'annotate', github: 'ctran/annotate_models'
gem 'anjlab-bootstrap-rails', require: 'bootstrap-rails', github: 'anjlab/bootstrap-rails'
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
gem 'byebug', platform: :mri, groups: [:development, :test]
gem 'carrierwave'
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .coffee assets and views
gem 'country_select'
gem 'chainable_methods' # experimental chaninable methods
gem 'dalli'
gem 'dotenv-rails'
gem 'font-awesome-sass-rails'
gem 'friendly_id', '5.0.4'
gem 'jb' # experimental replacement of jbuilder
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'kaminari'
gem 'liquid'
gem 'memcachier'
gem 'oj' # Optimized JSON
gem 'pg', '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma' # Use Puma as the app server
gem 'rails', '>= 5.0.0', '< 5.1'
gem 'redis', '~> 3.0' # Use Redis adapter to run Action Cable in production
gem 'responders'
gem 'rmagick',  require: false
gem 'rubocop',  require: false
gem 'rubyzip'
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'sidekiq'
gem 'skylight'
gem 'slim'
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'turbolinks', '~> 5.x' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'minitest-ci', git: 'git@github.com:circleci/minitest-ci.git'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'launchy'
  gem 'minitest-reporters'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end
