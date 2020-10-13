
# Shortbread

A delicious URL shortener, elegantly made with Ruby on Rails! See it live at http://shrtb.red.

## How to run locally

Install the dependencies specified in the Gemfile
```shell
$ sudo bundle install
```

Start a Homebrew PostgreSQL server
```shell
$ brew install postgresql
$ brew services start postgresql

$ export POSTGRES_USER=$(whoami)
```

Create, migrate, and seed the PostgreSQL databases
```shell
$ rails db:create db:migrate db:seed
```

Run the test suite with `rspec`
```shell
$ rspec
```

Start Rails server
```shell
$ export URL_BASE=localhost:3000/

$ rails server
```

## How to run locally with docker-compose

Use rake to orchestrate the containres
```shell
$ rails docker:start

$ rails docker:stop
```

## How to build and push Docker images

Use rake to build and push the Docker images
```shell
$ rake docker:push
```
---

Shortened URLs are case-sensitive, so bear that in mind.

The site tracks the top 100 most visited links. You can adjust this in the constant `MOST_VISITED_LIMIT` in link.rb.
