ruby '2.6.0'
source 'https://rubygems.org'

gem 'annotate', github: 'ctran/annotate_models'
gem 'anjlab-bootstrap-rails', require: 'bootstrap-rails', github: 'anjlab/bootstrap-rails'
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
gem 'bootsnap'
gem 'byebug', platform: :mri, groups: [:development, :test]
gem 'carrierwave'
gem 'coffee-rails' # Use CoffeeScript for .coffee assets and views
gem 'country_select'
gem 'chainable_methods' # experimental chaninable methods
gem 'dalli'
gem 'dotenv-rails'
gem 'font-awesome-sass-rails'
gem 'friendly_id'
gem 'graphql'
gem 'jb' # experimental replacement of jbuilder
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'kaminari'
gem 'liquid'
gem 'memcachier'
gem 'oj' # Optimized JSON
gem 'pg', '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma' # Use Puma as the app server
gem 'rails', '>= 5.2.0', '< 6'
gem 'redis' # Use Redis adapter to run Action Cable in production
gem 'responders'
gem 'test-unit'

# to instal this I had to
# export PKG_CONFIG_PATH=/usr/local/Cellar/imagemagick\@6/6.9.9-15/lib/pkgconfig
gem 'rmagick',  require: false
gem 'rubocop',  require: false
gem 'rubyzip'
gem 'sass-rails' # Use SCSS for stylesheets
gem 'sidekiq'
gem 'skylight'
gem 'slim'
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'turbolinks' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

group :development do
  gem 'graphiql-rails'
  gem 'listen'
  gem 'rubocop-rspec'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'minitest-ci' #, git: 'git@github.com:circleci/minitest-ci.git'
  gem 'minitest-reporters'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'shoulda-context'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end
