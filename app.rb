require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'sinatra/namespace'
require 'pry'
require 'mongoid'

%w[entities services serializers helpers].each do |dir|
  Dir.glob("./#{dir}/*.rb", &method(:require))
end

Mongoid.load! 'mongoid.config'

config_file 'config/settings.yml'

set :app_file, __FILE__
set :environment, :development

include RedisStore

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  helpers do
    def symbols
      params[:symbols]&.split(',') || ['USD']
    end

    def base
      params[:base] || 'EUR'
    end

    def cache_key(date)
      "#{date.to_s}_#{symbols.join('_')}"
    end

    def request_rate_for(date)
      cached_rate  = Marshal.load(get_from_cache(cache_key(date)))
      rate_from_db = ExchangeRate.base(base).date(date.to_s).symbols(symbols).first

      existing_rate = cached_rate || rate_from_db

      # TODO: fetch_and_store_rate if existing_rate.blank?
    end
  end

  # NOTE: this endpoint allows requests like /2019-12-31 (Fixer Historical Rates)
  get %r{/20\d{2}-\d{2}-\d{2}} do
    # optional params: base, symbols
    requested_date = Date.parse(request.path_info.split('/').last)

    if requested_date <= Date.today
      rate = request_rate_for(requested_date)

      json ExchangeRateSerializer.new(rate).to_json
    else
      halt 400, { message: 'Invalid date. Date format: 2019-12-31' }.to_json
    end
  end

  get '/latest' do
    # optional params: base, symbols
    rate = request_rate_for(Date.today)

    json ExchangeRateSerializer.new(rate).to_json
  end

  get '/timeseries' do
    # NOTE: Only paid Fixer subscription  allows this request
    # We have to do it day by day with free fixer plan
    # required params: start_date, end_date
    # optional params: base, symbols
    start_date = Date.parse(params[:start_date])
    end_date   = Date.parse(params[:end_date])

    if start_date <= end_date
      rates = Array(start_date..end_date).map do |date|
        ExchangeRateSerializer.new(request_rate_for(date))
      end.to_json

      json rates
    else
      halt 400, { message: 'Error: start_date must be before end_date.' }.to_json
    end
  end
end
