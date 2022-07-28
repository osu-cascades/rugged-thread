# Rugged Thread Ticketing System

## Setup

Once you install Ruby and Postgres, clone the repo, `cd` into it, and run
`bundle install` to install the library dependencies.

### Version Information

* Ruby version 3.x

* Rails version 7.x

* Postgresql version 13 or greater

### System Dependencies

Beyond the Rails defaults, the application uses the following gems.

* [ActsAsList](https://rubygems.org/gems/acts_as_list) - Numbering Items, Repairs, etc.
* [Airbrake](https://rubygems.org/gems/airbrake) - Exception notifications in production
* [Bootstrap](https://rubygems.org/gems/bootstrap) - Bootstrap 5 styles
* [Devise](https://rubygems.org/gems/devise) - Authentication
* [Discard](https://rubygems.org/gems/discard/versions/0.1.0) - Mark objects as discarded
* [Pagy](https://rubygems.org/gems/pagy/versions/0.6.0) - Pagination
* [pg](https://rubygems.org/gems/pg) - Postgres database driver
* [Phony](https://rubygems.org/gems/phony_rails) - Phone number validation and formatting
* [Pundit](https://rubygems.org/gems/pundit) - Authorization
* [QboApi](https://rubygems.org/gems/qbo_api) - Interacting with the QuickBooks API
* [Rack-OAuth2](https://rubygems.org/gems/rack-oauth2) - OAuth to connect QuickBooks with the application

### Configuration

We store API credentials in the nominal Rails credentials files, one for each
environment:

* config/credentials/development.yml.enc
* config/credentials/production.yml.enc

You must have a _config/credentials/development.key_ file containing the appropriate
key. Consult the project documentation or development team members for this key.
View and edit the credentials with
`rails credentials:edit --environment development`.

To view and modify the production credentials, you must have a
_config/credentials/production.key_ file containing the appropriate key. Consult
the project documentation or development team members for this key.

### Database

The migrations should run cleanly, and there is seed data in _db/seeds.rb_.
But, get up and running with `rails db:setup`.

## Test Suite

We use minitest, and you can run the test suite with `rails test` and
`rails test:system`. At the time of this writing (see `git blame README`), the
application doesn't use any client-side JavaScript, so the system tests use the
`:rack_test` driver to speed up the system tests.
See _test/application_system_test_case.rb_.

## Deployment

* [Heroku-CLI](https://devcenter.heroku.com/articles/heroku-cli) - Have the Heroku CLI installed
* Add a remote in your local repo to the production application
  with `heroku git:remote -a https://git.heroku.com/rugged-thread.git`
* Push changes from the main branch to Heroku using `git push heroku main`
* If you've made changes to the database, run migration using `heroku run rails db:migrate`


&copy; 2022 Rugged Thread, Brayden Brown, Andras Mihaly, Daniel Lau and Yong Bakos. All rights reserved.
