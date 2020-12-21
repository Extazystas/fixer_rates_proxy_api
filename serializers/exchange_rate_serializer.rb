class ExchangeRateSerializer
  attr_reader :rate

  def initialize(rate)
    @rate = rate
  end

  def as_json(*)
    data = {
      base: rate.base,
      date: rate.date,
      symbols: rate.symbols,
      rates: rate.rates
    }
  end
end
