class CreateRateService
  attr_reader :base, :date, :symbols, :rates

  def initialize(params)
    params.stringify_keys!

    @base    = params['base']
    @date    = params['date']
    @symbols = params['rates']&.keys
    @rates   = params['rates']
  end

  def call
    ExchangeRate.create!(base: base, date: date, symbols: symbols, rates: rates)
  end
end
