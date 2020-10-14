
# Shortbread [![Build Status](https://travis-ci.org/IlIIIllIlIlllllIIIIlllIlllIllllIlllllll/shortbread.svg?branch=master)](https://travis-ci.org/IlIIIllIlIlllllIIIIlllIlllIllllIlllllll/shortbread)

A delicious URL shortener, elegantly made with Ruby on Rails! See it live at http://shrtb.red.

Shortened URLs are case-sensitive, so bear that in mind.

The site tracks the top 100 most visited links. You can adjust this in the constant `MOST_VISITED_LIMIT` in link.rb.

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

When the docker images are pushed, they will be tagged with latest, the git commit sha, and a [tag](https://github.com/IlIIIllIlIlllllIIIIlllIlllIllllIlllllll/shortbread/tags) if one exists for the commit.

- [shrtbred tags](https://hub.docker.com/repository/docker/iliiillilillllliiiilllilllilll/shrtbred/tags?page=1)

- [shrtbred-nginx tags](https://hub.docker.com/repository/docker/iliiillilillllliiiilllilllilll/shrtbred-nginx/tags?page=1)

```shell
$ docker pull iliiillilillllliiiilllilllilll/shrtbred-nginx:latest

$ docker pull iliiillilillllliiiilllilllilll/shrtbred-nginx:v0.1.0

$ docker pull iliiillilillllliiiilllilllilll/shrtbred-nginx:3d78ca3
```
