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

docker-compose up
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

## Notes
The 'search by genre' functionality will only return results for your selected library! For example, if you search the Austin Branch for 'Epic' you will get no results, but if you switch to the Chicago Branch and try, you will get back The Hobbit (as it is the only book with that genre.)

Dates in the views are being deliberately `strftime`ed. There are SO many ways to format dates I didn't want to be dogmatic about it.

The db/seed file creates a standard user to log in as that has some example data populated (a newly loaned book, a 50% due book, an overdue book, a returned book) so that you don't have to manually populate anything.
