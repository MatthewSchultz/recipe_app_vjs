# README

A simple app to create, list, and search recipes. By the end of it, Matt will have figured out how to spell 'recipe' correctly.

## Stack Expectations

* Ruby v2.6.3 or later
* Rails v6.0.3 or later
* NodeJS v12 or later (and npm)
* YARN v1 or later
* PostgreSQL v10 or later (required for PgSearch implementation)

The Application is platform independent, and configured to run correctly on ephemeral file systems, like Heroku.

The installation of these tools on various platforms is beyond the scope of this readme, but a potential configuration for development can be found [here](https://github.com/MatthewSchultz/Install-Rails-on-WSL).

## Test Suite

The test suite is based on minitest (the default for Rails) and can be run with:

```bash
rails test
```

**ALL DEVELOPERS: Tests *must* pass before pushing to dev. Tests *must* pass before pushing to master.**

## Database Setup

Initially, database setup can be accomplished with ```rails db:create:all```.

Once initialized, the database can be maintained with:

```bash
rails db:migrate
rails db:seed
```

**WARNING: Continuous Integration is setup to run database migrations immediately following successful deployment. Do not initiate deployment without properly testing migrations. Failure to observe this may result in a yeti eating your data.**
