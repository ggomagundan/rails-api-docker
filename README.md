# README

Create a new single-node environment for this Rails API application using docker machine.

Build and run API app on the new environment using docker & docker compose

[Episode video link](https://youtu.be/4DSKgheuVns)

[![Episode Video Link](https://i.ytimg.com/vi/4DSKgheuVns/hqdefault.jpg)](https://youtu.be/4DSKgheuVns)

## Tested on

* macOS - 10.12
* Docker - 1.13.0
* Docker compose - 1.10.0


## Run this application on local

```
git clone https://github.com/ggomagundan/docker-rails-api.git
cd docker-rails-api
cp docker-compose.yml.sample docker-compose.yml
# edit docker-compose.yml to set the mariadb, redis(password) & rails ports to be mapped on host
cp .env.sample .env
# edit ENV variables
docker-compose build
bin/d_rails db:migrate
bin/d_rails db:seed
# Use REST client or curl to browse the APIs
curl http://localhost:3000/markets.json
```

## Docker image

```
# canister.io is one option
docker -t blog-api -t <REGISTRY/IMAGE-URI-PATH>
docker login --username=<REGISTRY USER> <REGISTRY>
docker push <REGISTRY/IMAGE-URI-PATH>
```

## Deploy to single-node env

```
cp docker-compose-staging.yml.sample docker-compose-staging.yml
# edit docker-compose-staging.yml for the image url
docker-compose -f docker-compose-staging.yml up

# edit ENV variables
cp .env.sample .env

# modify production.rb file L84 - L86
vi config/environments/production.rb

sudo mkdir -p /docker-machines/blog-staging
sudo chown -R $USER /docker-machines/blog-staging
export MACHINE_STORAGE_PATH=/docker-machines/blog-staging

# generate API access token on digitalocean.com
docker-machine create -d digitalocean --digitalocean-access-token=<DO ACCESS TOKEN> blog-staging
docker-machine ls
docker-machine ip blog-staging
eval $(docker-machine env blog-staging)
docker-compose -f docker-compose-staging.yml run --rm app rails db:migrate
docker-compose -f docker-compose-staging.yml run --rm app rails db:seed
docker-compose -f docker-compose-staging.yml up -d

# status, stop/start, logs
docker-compose -f docker-compose-staging.yml ps
docker-compose -f docker-compose-staging.yml stop
docker-compose -f docker-compose-staging.yml start
docker-compose -f docker-compose-staging.yml logs

docker-compose -f docker-compose-staging.yml stop app
docker-compose -f docker-compose-staging.yml start app

docker-compose -f docker-compose-staging.yml logs app
docker-compose -f docker-compose-staging.yml logs db

curl http://$(docker-machine ip blog-staging):3000/posts.json
```