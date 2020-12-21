## This is Exchange Rates API for Freska test application. Part of Test assignment for fetching exchange currencies data from fixer.io.
<p>
<img src="https://devicons.github.io/devicon/devicon.git/icons/ruby/ruby-original-wordmark.svg" alt="ruby" width="40" height="40"/>
<img src="https://devicons.github.io/devicon/devicon.git/icons/mongodb/mongodb-original-wordmark.svg" alt="mongodb" width="40" height="40"/>
<img src="https://devicons.github.io/devicon/devicon.git/icons/redis/redis-original-wordmark.svg" alt="redis" width="40" height="40"/>
</p>

## Description
It takes params:
- String `base`
- String `start_date`, `end_date` (e.g. `2020-12-12`)
- Array `currencies` (e.g. ['USD', 'DKK'])

- Units specs written with `Rspec`.
- Rates info is fetched from Fixer.io, cached in Redis and persisted in MongoDB.

- **Rubocop** is used for a good code style. Run example: `rubocop`

## Tech info:
* Sinatra v 2.1
* Ruby version 2.6
* Caching layer: Redis
* Persistance layer: MongoDB

## Setup
You can run this app with `rackup -p 4567`:

## Run tests:
`RACK_ENV=test rspec spec/`

## API example call:
```
http://localhost:4567/api/v1/timeseries?start_date=2020-12-01&end_date=2020-12-03&base=EUR&symbols=GBP,DKK,USD
```
