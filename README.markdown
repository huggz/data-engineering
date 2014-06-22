# Challenge for Software Engineer - Big Data

Included in this repository is my solution to LivingSocial's Software Engineer
Challenge.  It makes use of Ruby on Rails to solve the three primary goals of:

1.  accepting (via webform) a tab-delimited file of purchase data,
2.  parsing the file, normalizing the data, and storing in a relational DB, and
3.  displaying the total amount gross revenue represented by the file.

It additionally performs the bonus requirement of implementing authentication.

## Installation

To set up the application on your (Linux or OS X) system:

1.  Clone the repository.
2.  Install Ruby 2.1.0 if not already installed.  (Optionally use
    [rvm](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv) to
    specify a Ruby environment for your Ruby binary & gemset.)
3.  `cd` into the top-level repo folder, and run `bundle install` to install the
    gems needed by the app.
4.  Run `bundle exec db:setup` to create your database and prepare its schema.
5.  Run `bundle exec rails server` to run the server.

## Usage

1.  Open [localhost:3000](http://localhost:3000) in your web browser.
2.  Click the "Get started" button to create a new user account.
3.  After signing up, you will be taken to the CSV upload page.  Use the form
    to upload a CSV matching the format specified by the challenge.  (Optionally
    upload a file not matching the format to see how error cases are handled.)
4.  After performing a successful upload, you will be taken to the merchants page
    where you can verify the gross revenue represented by the file as well as all
    data imported to date.  Item and purchase data is nested under each merchant.

## Testing

Unit and controller tests are implemented via [RSpec](http://rspec.info/) and
make use of [FactoryGirl](https://github.com/thoughtbot/factory_girl) and
[Faker](https://github.com/stympy/faker).  The test suite can be run from the
command line via `bundle exec rspec`.
