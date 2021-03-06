source 'https://rubygems.org'

ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # BDD
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  # gem 'capybara'
  # gem 'cucumber-rails', :require => false
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'

end

group :development do
  # Use travis CI command
  # gem 'travis'

  # JavaScript Interpreter
  # gem 'therubyracer', platforms: :ruby
  # ver 3.16.14.8 error

  # Debugger
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'hirb-unicode'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # chrome addon
  gem 'meta_request'

  # generate ER
  gem 'rails-erd'

end

# codeclimate
group :test do
  gem "codeclimate-test-reporter", require: nil
end

# heroku settings
group :production do
  gem 'rails_12factor'
  gem 'pg'
  gem 'unicorn'
end

# Ootalk
gem 'ootalk', :git => 'https://github.com/SBR2015/ootalk.git'

# database settings
# gem 'foreigner'

# newrelic
gem 'newrelic_rpm'

# emberjs integration
gem 'ember-cli-rails'

# login settings
gem 'devise'
gem 'omniauth'
gem 'devise_token_auth'

gem 'rails_admin'
gem 'doorkeeper'
gem 'i18n-js'
gem 'rack-cors', :require => 'rack/cors'
