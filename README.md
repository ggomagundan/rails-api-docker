# README

Create a new single-node environment for this Rails API application using docker machine.

Build and run API app on the new environment using docker & docker compose

[Episode video link](https://youtu.be/4DSKgheuVns)

[![Episode Video Link](https://i.ytimg.com/vi/4DSKgheuVns/hqdefault.jpg)](https://youtu.be/4DSKgheuVns)


* macOS - 10.12
* Docker - 1.13.0
* Docker compose - 1.10.0


## Run this application on local

- APP: Rails v5.0.1 
- Nginx : v1.11.10
- DB: MariaDB v10.1
- ElasticSearch : v5.2.1
- Redis: v3.2-alpine

```
git clone https://github.com/ggomagundan/rails-api-docker.git
cd rails-api-docker
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

## Thanks to

 [Original Source
(Deploy-with-docker-rails-api-single-node)](https://github.com/devteds/e5-deploy-with-docker-rails-api-single-node)

 [Korean ElasticSearch With Mecab, 은전한닢(N42Corp)](https://github.com/n42corp/elasticsearch)


