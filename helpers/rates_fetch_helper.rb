module Sinatra
  module RatesFetchHelper
    attr_reader :date

    def symbols
      params[:symbols]&.split(',') || ['USD']
    end

    def base
      params[:base] || 'EUR'
    end

    def request_rate_for(date)
      @date = date

      fetch_existing_rate_for || create_rate_from_api
    end

    def fetch_existing_rate_for
      cached_marshalled_rate = get_from_cache(cache_key)
      cached_rate  = cached_marshalled_rate && Marshal.load(cached_marshalled_rate)
      rate_from_db = ExchangeRate.base(base).date(date.to_s).symbols(symbols).first

      cached_rate || rate_from_db
    end

    def create_rate_from_api
      response = fetch_rate_from_api

      if response['success']
        rate = CreateRateService.new(response).call
        set_cache(cache_key, Marshal.dump(rate)) if rate.valid?
        rate
      else
        halt 400, response['error'].to_json
      end
    end

    def fetch_rate_from_api
      FixerRatesFetcher.new(base, date, symbols).call
    end

    def cache_key
      "#{date}_#{symbols.join('_')}"
    end
  end

  helpers RatesFetchHelper
end
