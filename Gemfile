source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'acts_as_list'
gem 'airbrake'
gem "bootsnap", require: false
gem 'bootstrap', '~> 5.1.3'
gem 'devise'
gem 'discard', '~> 1.2'
gem "importmap-rails"
# gem "image_processing", "~> 1.2"
gem "jbuilder"
gem 'money-rails'
gem 'pagy'
gem 'pg'
gem 'phony_rails'
gem "puma", "~> 5.0"
gem 'pundit'
gem "rails", "~> 7.0.2.3"
gem "sassc-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "qbo_api"
gem "rack-oauth2"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  # gem "rack-mini-profiler"
  # gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
