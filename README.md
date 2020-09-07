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

docker-compose run web rake db:up
```
