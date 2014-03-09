source 'https://rubygems.org'
ruby '2.0.0'

gem 'pg'
gem 'haml'
gem 'chronic_duration'
gem 'better_errors', group: :development
gem 'binding_of_caller'
gem 'rest-client'
gem 'sidekiq'
gem 'sinatra', :require => nil
gem 'transitions', :require => ['transitions', 'active_model/transitions']
gem 'sorcery'

group :test do
  gem 'fabrication'
  gem 'rspec-rails'

  gem 'simplecov'
  gem 'shoulda-matchers'
end

group :test, :development do
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-debugger'
  gem 'pry-doc'
  gem 'guard-rspec'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
