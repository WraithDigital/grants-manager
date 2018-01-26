# GTC Grants-Manager

## Development Mode

### Starting Server

To start server in development you must run

`bundle exec rails s`

plus any desired flags to start server. Country codes wont work without this.

### Starting que

to start the que worker you must run

`bundle exec que ./config/environment.rb`

The que worker must be running for the sync functionality to work

## Deploying to Heroku

Once the branch is up to date with 'origin/master', run

`git push heroku master`

This will push the app to heroku. Heroku will run its deployment scripts and spin up all necessary workers.

### Heroku Migration

If you have migrations to run then the following code needs to be executed in console

`heroku run rake db:migrate`

If you also have and db seeding to do you need to run

`heroku run rake db:seed`
