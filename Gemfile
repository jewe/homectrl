source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'mysql2'

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'purecss-rails'
gem "font-awesome-rails"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# app server
gem 'thin'

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'rubyserial'
gem 'whenever'#, :require => false # cron jobs for reading xbee
gem 'databound', '3.0.3' # js helper for rails models https://github.com/Nedomas/databound
gem 'lodash-rails' # dependency of databound

# NTP Time Access, https://github.com/zencoder/net-ntp
gem 'net-ntp' 

group :development do
    	gem 'capistrano', '~> 3.0', require: false, group: :development
	gem 'capistrano-rvm'
	gem 'capistrano-rails', '~> 1.1', require: false
	gem 'capistrano-bundler', '~> 1.1', require: false
end