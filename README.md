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
* [Discard](https://rubygems.org/gems/discard/versions/0.1.0) - Mark objects as discarded
* [Pagy](https://rubygems.org/gems/pagy/versions/0.6.0) - Pagination
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

### Data Model Nuances

#### Standardization

Many models (Repairs, Complications, InventoryItems, Items, etc.) have a 'Standard' 
parent - the purpose of this is to retain the details associated with the child model 
at the time of the transaction, while also allowing for the 'Standard' model to be 
adjusted as needed over time. For example, this season the FullZipperReplacement 
'Standard' Repair may be priced at $25, but if it goes up $5 dollars next year we'd 
like existing repair records to retain the original price to ensure data integrity.

#### Archiving

Many of the same models, in addition to WorkOrders and a few others, can be archived. 
This is most significant in cases where a 'standard' models record needs to be phased 
out but it has many chlid records associated with it. For example, if Rugged Tread has 
been charging a Processing Fee and they would like to phase it out, in order to retain 
the existing ProcessingFees associated with it and honor the existing foreign key 
constrain a User can simply archive the record. All this does is flag the record as 
archived; archived records can be viewed and recovered. 


&copy; 2022 Rugged Thread, Brayden Brown, Andras Mihaly and Yong Bakos. All rights reserved.
