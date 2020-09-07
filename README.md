# README

This project was creatd with Ruby 2.7.1

# Getting started
## Install docker and docker-compose
https://docs.docker.com/engine/install/#server
https://docs.docker.com/compose/install/

## Get the app started via docker
docker-compose build

docker-compose run web rake db:create
docker-compose run web rake db:migrate

docker-compose run web rake db:up


