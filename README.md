# Rugged Thread Ticketing System

## Setup

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
* [Kaminari](https://rubygems.org/gems/kaminari) - Pagination
* [pg](https://rubygems.org/gems/pg) - Postgres database driver
* [Phony](https://rubygems.org/gems/phony_rails) - Phone number validation and formatting
* [Pundit](https://rubygems.org/gems/pundit) - Authorization

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

### Database (TODO)

The migrations should run cleanly, and there is seed data in _db/seeds.rb_.
But, get up and running with `rails db:setup`.

## Test Suite

We use minitest, and you can run the test suite with `rails test` and
`rails test:system`. At the time of this writing (see `git blame README`), the
application doesn't use any client-side JavaScript, so the system tests use the
`:rack_test` driver to speed up the system tests.
See _test/application_system_test_case.rb_.

### TODO

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions - forthcoming (heroku)

* ...

&copy; 2022 Rugged Thread, Brayden Brown, Andras Mihaly and Yong Bakos. All rights reserved.
