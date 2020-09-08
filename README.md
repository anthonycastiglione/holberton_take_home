# README

This project was created with Ruby 2.7.1. You can use anything you like to install this version, I like https://github.com/rbenv/rbenv personally

# Getting started
## Install docker and docker-compose
https://docs.docker.com/engine/install/#server

https://docs.docker.com/compose/install/

## Get the app started via docker
```
docker-compose build

docker-compose run web rake db:create
docker-compose run web rake db:migrate
docker-compose run web rake db:seed

docker-compose run web rake db:up
```

## Usage
Navigating to http://localhost:3000/ will allow you to create/log in as a standard User.

Navigating to http://localhost:3000/staffs will allow you to create/log in as a Staff user. There is currently (deliberately) nothing preventing anyone from creating a staff user for ease-of-use of this take home project. In the real world you would us course wish to prevent this, typically not allowing Admin-type users to be created via the unauthenticated UI at all and restricting it to already-created admin users or even console-only access.

A seed file containing several books is included as part of set-up

## Run specs
Run the test suite:
```
docker-compose run web bundle exec rails test
```
