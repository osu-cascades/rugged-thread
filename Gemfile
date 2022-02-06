source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'airbrake'
gem "bootsnap", require: false
gem 'bootstrap', '~> 5.1.3'
gem 'devise'
gem "importmap-rails"
# gem "image_processing", "~> 1.2"
gem "jbuilder"
gem 'pg'
gem "puma", "~> 5.0"
gem 'pundit'
gem "rails", "~> 7.0.1"
gem "sassc-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

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
