source 'https://rubygems.org'

ruby "2.2.2"

gem 'rails', '4.2.1'
gem 'rails-api'
gem 'compass', :require => false

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'sqlite3'
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end

# To use Jbuilder templates for JSON
gem 'jbuilder'

# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
