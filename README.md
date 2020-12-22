## This is Exchange Rates API for Freska test application. Part of Test assignment for fetching exchange currencies data from fixer.io.
<p>
<img src="https://devicons.github.io/devicon/devicon.git/icons/ruby/ruby-original-wordmark.svg" alt="ruby" width="40" height="40"/>
<img src="https://devicons.github.io/devicon/devicon.git/icons/mongodb/mongodb-original-wordmark.svg" alt="mongodb" width="40" height="40"/>
<img src="https://devicons.github.io/devicon/devicon.git/icons/redis/redis-original-wordmark.svg" alt="redis" width="40" height="40"/>
</p>

## Description
API has 3 endpoints:
1) any date request e.g. `api/v1/2019-12-17`
2) current rates request `api/v1/latest`
3) dates period request `api/v1/timeseries` (its paid feature in Fixer, so use carefully - each day is 1 request)

It takes params:
- String `base` (e.g. `base=EUR`). Default value is `EUR`.
- String `symbols` (e.g. `symbols=USD,DKK`). Default value is `USD`.
- String `start_date`, `end_date` (e.g. `2020-12-12`) only for `/timeseries` endpoint

- Units specs written with `Rspec`.
- Rates info is fetched from Fixer.io, cached with Redis and stored in MongoDB.
- **Rubocop** is used for a good code style. Run example: `rubocop`

## Tech info:
* Sinatra v 2.1
* Ruby version 2.6
* Caching layer: Redis
* Persistance layer: MongoDB

## Setup
You can start this app with `rackup -p 4567`:

## Run tests:
`RACK_ENV=test rspec spec/`

## API example call:
```
curl -H "Content-Type: application/json" http://localhost:4567/api/v1/timeseries?start_date=2020-12-20&end_date=2020-12-22&base=EUR&symbols=GBP,USD

curl -H "Content-Type: application/json" http://localhost:4567/api/v1/2019-12-17?symbols=GBP,USD

curl -H "Content-Type: application/json" http://localhost:4567/api/v1/latest\?symbols\=GBP,USD,DKK
```

## TODO List
- Add API authentication (e.g. with jwt)
- Add logging system
- Configure docker-compose to avoid manual installation of MongoDB and Redis
- Add tests for app helpers
