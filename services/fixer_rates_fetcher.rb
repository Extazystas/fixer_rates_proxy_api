require 'faraday'
require 'json'

class FixerRatesFetcher
  attr_reader :base, :date, :symbols

  def initialize(base, date, symbols)
    @date    = date.to_s
    @base    = base
    @symbols = symbols.join(',')
  end

  def call
    response = Faraday.get(
      "#{Sinatra::Application.settings.fixer_api_url}/#{date}",
      query_params,
      headers
    )

    JSON.parse(response.body)
  end

  private

  def query_params
    {
      access_key: Sinatra::Application.settings.fixer_api_key,
      date: date.to_s,
      base: base,
      symbols: symbols
    }
  end

  def headers
    { 'Accept' => 'application/json' }
  end
end
