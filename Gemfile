source 'https://rubygems.org'
ruby '2.0.0'

#MAGIC
gem 'rails', '~> 4.0.1'

#DATABASES
gem 'pg'
gem 'pg-hstore'

#JSON PARSING
gem 'multi_json'

#CRON
gem 'sidetiq'

#QUEUES
gem 'sidekiq'
gem 'sinatra'
gem 'slim'

#APIs
gem 'crunchbase'

#WEB SERVERS
gem 'unicorn'

#HTML TEXT EDITOR
gem 'ckeditor_rails'

#OTHER
gem 'nokogiri'
gem 'httparty'
gem 'redis'
gem 'jbuilder', '~> 1.2'

#JAVASCRIPT
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

group :production do
  #HEROKU
  gem 'rails_12factor'

  #MANAGEMENT SYSTEMS
  #gem 'newrelic_rpm'
end

group :test, :development do
  gem 'pry' #debugging
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'fakeredis', require: 'fakeredis/rspec'
  gem 'timecop'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'ffaker'
  gem 'rspec-sidekiq'
end

group :development do
  gem 'annotate'
  gem 'figaro' #ENV VARIABLES (application.yml)
end
