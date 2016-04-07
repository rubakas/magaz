ruby "2.3.0"
source "https://rubygems.org"

# Your gem is dependent on dev or edge Rails. Once you can lock this
# dependency down to a specific version, move it to your gemspec.
# gem 'rails',            github: 'rails/rails', branch: '4-2-stable'
# gem 'rack',             github: 'rack/rack'
# gem 'arel',             github: 'rails/arel'
# gem 'i18n',             github: 'svenfuchs/i18n'

gem 'active_interaction'

gem 'rails',            github: 'rails/rails', branch: '4-2-stable'

# Use postgresql as the database for Active Record
gem 'pg'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'

gem 'memcachier'
gem 'dalli'

# Use inherited_resources for clear controllers
gem 'inherited_resources'

# Use slim-lang for templates
gem 'slim'

# Use edge version of sprockets-rails
gem 'sprockets-rails'#,  github: "rails/sprockets-rails"

# Use SCSS for stylesheets
gem 'sass-rails'#,       github: "rails/sass-rails"

# Use twitter bootstrap and font icons
gem 'anjlab-bootstrap-rails',
  require: 'bootstrap-rails',
  github: 'anjlab/bootstrap-rails'
gem 'font-awesome-sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails',     github: "rails/coffee-rails"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',     platforms: :ruby
gem 'kaminari'

# Use for country select forms
gem 'country_select', github: 'stefanpenner/country_select'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc',             group: :doc, require: false

# Use puma as the app server
gem 'puma'

# Use skylight.io for profiling and error detection
gem 'skylight'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'rubocop', :require => false
gem 'parallel_tests', group: :development
gem 'flog', group: :development
gem 'flay', group: :development
gem 'web-console', group: :development

gem 'cucumber-rails', :require => false, group: :test
gem 'capybara-webkit', "~> 1.5.2", group: :test
# gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master' #, group: :test
gem 'factory_girl', group: :test
gem 'launchy', group: :test # save_and_open_page need this
gem 'database_cleaner', group: :test


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.9', require: 'bcrypt'

# Use for upload files in app
gem "carrierwave"
gem "rmagick",          require: false

# Use liquid templates for themes
gem 'liquid'


# To use a debugger
# gem 'byebug', group: [:development, :test]
# gem 'annotate' , github: 'ctran/annotate_models'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',     platforms: :ruby


# To use a debugger
# gem 'byebug', group: [:development, :test]

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/jonleighton/spring
gem 'spring',           group: :development

