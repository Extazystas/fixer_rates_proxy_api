require 'faraday'
require 'json'

class FixerRatesFetcher
  BASE_URL = 'http://data.fixer.io/api'.freeze

  private_constant :BASE_URL

  attr_reader :base, :date, :symbols

  def initialize(base, date, symbols)
    @date    = date.to_s
    @base    = base
    @symbols = symbols.join(',')
  end

  # NOTE: response example: {"success":true,"timestamp":1608508799,"historical":true,"base":"EUR","date":"2020-12-20","rates":{"USD":1.221575}}
  def call
    response = Faraday.get("#{BASE_URL}/#{date}", query_params, { 'Accept' => 'application/json' })
    JSON.parse(response.body)
  end

  def query_params
    {
      access_key: Sinatra::Application.settings.fixer_api_key,
      date:       date.to_s,
      base:       base,
      symbols:    symbols
    }
  end
end
